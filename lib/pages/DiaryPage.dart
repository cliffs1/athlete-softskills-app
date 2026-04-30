import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../data/diary_AI.dart';
import 'ResultAIPage.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  final supabase = Supabase.instance.client;
  bool? completedToday;
  final int totalQuestions = 5;
  final List<int?> answers = List<int?>.filled(4, null);
  String emotionalText = "";
  late final PageController _pageController;
  int currentQuestion = 0;
  final TextEditingController _textController = TextEditingController();
  List<String> questions = [
    "Ar šiandien bandei pritaikyti naujai išmoktas žinias?",
    "Kaip vertini savo pasitikėjimą savimi šiandien?",
    "Kaip gerai bendravai su komandos nariais?",
    "Kaip vertini savo tobulėjimą?",
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    checkIfCompletedToday();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> checkIfCompletedToday() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;
    final today = DateTime.now().toIso8601String().split('T')[0];
    final response = await supabase
        .from('dienorastis')
        .select()
        .eq('user_id', user.id)
        .eq('entry_date', today);
    setState(() {
      completedToday = response.isNotEmpty;
    });
  }

  Future<void> goToNextQuestion() async {
    if (currentQuestion < totalQuestions - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final user = supabase.auth.currentUser;
      if (user == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Color.fromRGBO(167, 139, 250, 1),
                  ),
                  SizedBox(height: 16),
                  Text("AI coach'as analizuoja..."),
                ],
              ),
            ),
          ),
        ),
      );

      try {
        final coachResponse = await AiCoachService.analyzeEntry(
          diaryText: emotionalText,
          answers: answers,
        );

        final Map<String, dynamic> data = {
          'user_id': user.id,
          'entry_date': DateTime.now().toIso8601String().split('T')[0],
          'emocijostekstas': emotionalText,
          'ai_analysis': coachResponse.analysis,
          'ai_tip': coachResponse.tomorrowTip,
          'stats_applied': false,
        };
        for (int i = 0; i < answers.length; i++) {
          data['q${i + 1}'] = answers[i];
        }
        await supabase.from('dienorastis').insert(data);
        await _applyDiaryStatsIfEligible(user.id);

        setState(() {
          completedToday = true;
        });

        if (!mounted) return;
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CoachResultPage(response: coachResponse),
          ),
        );
      } catch (e) {
        if (!mounted) return;
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Klaida: $e')),
        );
      }
    }
  }

  Future<void> goToPreviousQuestion() async {
    if (currentQuestion > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool canProceed(int index) {
    if (index < 4) {
      return answers[index] != null;
    } else {
      return emotionalText.trim().isNotEmpty;
    }
  }

  int wordCount(String text) {
    return text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  String _dateOnly(DateTime date) {
    final localDate = DateTime(date.year, date.month, date.day);
    return localDate.toIso8601String().split('T')[0];
  }

  String _normalizeSkillName(String value) {
    const replacements = {
      'ą': 'a',
      'č': 'c',
      'ę': 'e',
      'ė': 'e',
      'į': 'i',
      'š': 's',
      'ų': 'u',
      'ū': 'u',
      'ž': 'z',
    };

    var normalized = value.toLowerCase().trim();
    replacements.forEach((from, to) {
      normalized = normalized.replaceAll(from, to);
    });

    normalized = normalized.replaceAll(RegExp(r'[^a-z0-9]+'), ' ');
    return normalized.trim();
  }

  double _scaleAnswerToScore(dynamic value) {
    final answer = value is int ? value : int.tryParse(value?.toString() ?? '');
    if (answer == null) return 0;
    return (answer * 2).clamp(0, 10).toDouble();
  }

  double _yesNoAnswerToScore(dynamic value) {
    final answer = value is int ? value : int.tryParse(value?.toString() ?? '');
    return answer == 1 ? 10 : 4;
  }

  void _addScore(Map<String, List<double>> buckets, String skill, double score) {
    if (score <= 0) return;
    buckets.putIfAbsent(skill, () => []);
    buckets[skill]!.add(score);
  }

  double _average(List<double> values) {
    if (values.isEmpty) return 0;
    return values.reduce((sum, value) => sum + value) / values.length;
  }

  Future<int> _getNextTableId(String tableName) async {
    final response = await supabase
        .from(tableName)
        .select('id')
        .order('id', ascending: false)
        .limit(1);

    final rows = response as List;
    if (rows.isEmpty) return 1;

    final lastId = rows.first['id'] as int?;
    return (lastId ?? 0) + 1;
  }

  Future<void> _applyDiaryStatsIfEligible(String userId) async {
    try {
      final today = DateTime.now();
      final requiredDates = [
        _dateOnly(today),
        _dateOnly(today.subtract(const Duration(days: 1))),
        _dateOnly(today.subtract(const Duration(days: 2))),
      ];

      final diaryRows = await supabase
          .from('dienorastis')
          .select('id, entry_date, q1, q2, q3, q4, stats_applied')
          .eq('user_id', userId)
          .inFilter('entry_date', requiredDates);

      final entriesByDate = <String, Map<String, dynamic>>{};
      for (final row in diaryRows as List) {
        final entry = Map<String, dynamic>.from(row);
        final entryDate = entry['entry_date']?.toString();
        if (entryDate != null) {
          entriesByDate[entryDate] = entry;
        }
      }

      if (!requiredDates.every(entriesByDate.containsKey)) return;

      final entriesToApply = requiredDates.map((date) => entriesByDate[date]!);
      if (entriesToApply.any((entry) => entry['stats_applied'] == true)) {
        return;
      }

      final scoreBuckets = <String, List<double>>{};
      for (final entry in entriesToApply) {
        final practiceScore = _yesNoAnswerToScore(entry['q1']);
        final confidenceScore = _scaleAnswerToScore(entry['q2']);
        final communicationScore = _scaleAnswerToScore(entry['q3']);
        final growthScore = _scaleAnswerToScore(entry['q4']);

        _addScore(scoreBuckets, 'motyvacija', practiceScore);
        _addScore(scoreBuckets, 'atsakomybė', practiceScore);
        _addScore(scoreBuckets, 'pasitikėjimas savimi', confidenceScore);
        _addScore(scoreBuckets, 'komunikacija', communicationScore);
        _addScore(scoreBuckets, 'komandinis darbas', communicationScore);
        _addScore(scoreBuckets, 'motyvacija', growthScore);
        _addScore(scoreBuckets, 'atsakomybė', growthScore);
      }

      await _saveDiarySkillScores(userId, scoreBuckets);

      final appliedEntryIds = entriesToApply
          .map((entry) => entry['id'])
          .whereType<int>()
          .toList();
      if (appliedEntryIds.isNotEmpty) {
        await supabase
            .from('dienorastis')
            .update({'stats_applied': true}).inFilter('id', appliedEntryIds);
      }
    } catch (e) {
      debugPrint('Nepavyko pritaikyti dienoraščio statistikai: $e');
    }
  }

  Future<void> _saveDiarySkillScores(
    String userId,
    Map<String, List<double>> scoreBuckets,
  ) async {
    if (scoreBuckets.isEmpty) return;

    final skillDefinitions = await supabase
        .from('minkstieji_gebejimai')
        .select('id, pavadinimas');

    final currentSkillRows = await supabase
        .from('naudotojo_minkstieji')
        .select('id, fk_minkstieji_gebejimai, svoris')
        .eq('fk_naudotojas', userId);

    final normalizedSkillIds = <String, int>{};
    for (final item in skillDefinitions as List) {
      final name = item['pavadinimas']?.toString();
      final id = item['id'] as int?;
      if (name == null || id == null) continue;
      normalizedSkillIds[_normalizeSkillName(name)] = id;
    }

    final currentSkillMap = <int, Map<String, dynamic>>{};
    for (final item in currentSkillRows as List) {
      final skillId = item['fk_minkstieji_gebejimai'] as int?;
      if (skillId == null) continue;
      currentSkillMap[skillId] = Map<String, dynamic>.from(item);
    }

    for (final entry in scoreBuckets.entries) {
      final skillId = normalizedSkillIds[_normalizeSkillName(entry.key)];
      if (skillId == null) {
        debugPrint('Nerastas įgūdžio ID dienoraščio kategorijai: ${entry.key}');
        continue;
      }

      final diaryScore = _average(entry.value);
      final currentRow = currentSkillMap[skillId];
      final previousWeight = currentRow == null
          ? null
          : (currentRow['svoris'] as num?)?.toDouble();
      final newWeight = (previousWeight == null
              ? diaryScore
              : (previousWeight * 0.9) + (diaryScore * 0.1))
          .clamp(0, 10)
          .toDouble();

      if (currentRow == null) {
        final nextCurrentId = await _getNextTableId('naudotojo_minkstieji');
        await supabase.from('naudotojo_minkstieji').insert({
          'id': nextCurrentId,
          'fk_naudotojas': userId,
          'fk_minkstieji_gebejimai': skillId,
          'svoris': newWeight,
        });
      } else {
        await supabase
            .from('naudotojo_minkstieji')
            .update({'svoris': newWeight}).eq('id', currentRow['id']);
      }

      final nextHistoryId = await _getNextTableId(
        'naudotojo_minkstieji_history',
      );
      await supabase.from('naudotojo_minkstieji_history').insert({
        'id': nextHistoryId,
        'fk_naudotojas': userId,
        'fk_minkstieji_gebejimai': skillId,
        'svoris': newWeight,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = (currentQuestion + 1) / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Dienoraštis",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Image.asset('assets/brain_logo_goodremakecolor.png', height: 60),
        ],
      ),
      body: completedToday == null
          ? const Center(child: CircularProgressIndicator())
          : completedToday!
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 10),
                        const Text(
                          "Šiandien jau užpildei dienoraštį!",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: LinearProgressIndicator(value: progress),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: totalQuestions,
                        onPageChanged: (index) {
                          setState(() {
                            currentQuestion = index;
                          });
                        },
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: index < 4
                                    ? buildScaleQuestion(index)
                                    : buildTextQuestion(),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget buildScaleQuestion(int index) {
    if (index == 0) return buildYesNoQuestion(index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Klausimas ${index + 1}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(questions[index], style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          children: List.generate(5, (i) {
            final value = i + 1;
            final selected = answers[index] == value;
            return GestureDetector(
              onTap: () => setState(() => answers[index] = value),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: selected
                      ? const Color.fromRGBO(56, 189, 248, 1)
                      : Colors.grey.shade200,
                ),
                child: Text(
                  value.toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: selected ? Colors.white : Colors.black87,
                  ),
                ),
              ),
            );
          }),
        ),
        const Spacer(),
        navigationButtons(index),
      ],
    );
  }

  Widget buildYesNoQuestion(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Klausimas ${index + 1}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Text(questions[index], style: const TextStyle(fontSize: 18)),
        const SizedBox(height: 32),
        Row(children: [
          Expanded(child: yesNoButton(index, 1, "Taip")),
          const SizedBox(width: 12),
          Expanded(child: yesNoButton(index, 0, "Ne")),
        ]),
        const Spacer(),
        navigationButtons(index),
      ],
    );
  }

  Widget yesNoButton(int index, int value, String text) {
    final selected = answers[index] == value;
    return GestureDetector(
      onTap: () => setState(() => answers[index] = value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 60,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selected
              ? const Color.fromRGBO(56, 189, 248, 1)
              : Colors.grey.shade200,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: selected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget buildTextQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kaip bendrai jautiesi šiandien? (savo žodžiais)',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _textController,
          maxLines: 6,
          onChanged: (value) {
            if (wordCount(value) <= 200) {
              setState(() => emotionalText = value);
            }
          },
          decoration: const InputDecoration(
            hintText: 'Parašyk iki 200 žodžių...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Žodžiai: ${wordCount(_textController.text)} / 200',
          style: const TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        navigationButtons(4),
      ],
    );
  }

  Widget navigationButtons(int index) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            style: ButtonStyle(
              side: WidgetStateProperty.resolveWith<BorderSide>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return BorderSide(color: Colors.grey.shade300);
                }
                return const BorderSide(color: Color.fromRGBO(167, 139, 250, 1));
              }),
              foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey;
                }
                return const Color.fromRGBO(11, 18, 32, 1);
              }),
            ),
            onPressed: index == 0 ? null : goToPreviousQuestion,
            child: const Text('Atgal'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
                if (states.contains(WidgetState.disabled)) {
                  return Colors.grey.shade300;
                }
                return const Color.fromRGBO(56, 189, 248, 1);
              }),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),
            onPressed: canProceed(index) ? goToNextQuestion : null,
            child: Text(index == totalQuestions - 1 ? 'Išsaugoti' : 'Kitas'),
          ),
        ),
      ],
    );
  }
}
