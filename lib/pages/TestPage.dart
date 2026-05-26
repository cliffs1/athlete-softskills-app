import 'package:flutter/material.dart';
import 'package:softskills_app/data/test_questions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:math';

class TestQuestionEntry {
  final String categoryId;
  final String categoryTitle;
  final String categoryDbSkillName;
  final SoftSkillQuestion question;

  const TestQuestionEntry({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryDbSkillName,
    required this.question,
  });
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final supabase = Supabase.instance.client;
  final List<TestQuestionEntry> _questions = [];
  final Random _random = Random();

  late final PageController _pageController;
  List<String?> answers = [];
  int currentQuestion = 0;
  bool isLoading = true;
  bool isSubmitting = false;
  String? userSportType;
  bool testUnavailable = false;

  int get totalQuestions => _questions.length;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    loadTestData();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> loadTestData() async {
    final canTake = await _canTakeTest();

    if (!canTake) {
      if (!mounted) return;

      setState(() {
        testUnavailable = true;
        isLoading = false;
      });

      return;
    }

    final sportType = await _loadUserSportType();
    final questions = _buildTestQuestionsForSport(sportType);

    questions.shuffle(_random);

    if (!mounted) return;

    setState(() {
      userSportType = sportType;
      _questions
        ..clear()
        ..addAll(questions);
      answers = List<String?>.filled(questions.length, null);
      isLoading = false;
    });
  }

  Future<bool> _canTakeTest() async {
    final user = supabase.auth.currentUser;
    if (user == null) return false;

    try {
      final oneWeekAgo = DateTime.now().subtract(const Duration(days: 7));

      final response = await supabase
          .from('test_history')
          .select('completed_at')
          .eq('fk_naudotojas', user.id)
          .gte('completed_at', oneWeekAgo.toIso8601String())
          .order('completed_at', ascending: false)
          .limit(1);

      final rows = response as List;

      return rows.isEmpty;
    } catch (e) {
      debugPrint('Nepavyko patikrinti testo istorijos: $e');
      return false;
    }
  }

  List<TestQuestionEntry> _buildTestQuestionsForSport(String? sportType) {
    const questionsPerSkill = 3;
    final selectedQuestions = <TestQuestionEntry>[];

    for (final category in softSkillQuestionCategories) {
      final sportQuestions = category.questions
          .where((question) => question.isForSport(sportType))
          .toList()
        ..shuffle(_random);

      selectedQuestions.addAll(
        sportQuestions.take(questionsPerSkill).map(
          (question) => TestQuestionEntry(
            categoryId: category.id,
            categoryTitle: category.title,
            categoryDbSkillName: category.dbSkillName,
            question: question,
          ),
        ),
      );
    }

    return selectedQuestions;
  }

  Future<String?> _loadUserSportType() async {
    final user = supabase.auth.currentUser;
    if (user == null) return null;

    try {
      final data = await supabase
          .from('naudotojas')
          .select('fk_sporto_saka')
          .eq('auth_user_id', user.id)
          .maybeSingle();

      final sportId = data?['fk_sporto_saka'] as int?;
      return _mapSportIdToType(sportId);
    } catch (e) {
      debugPrint('Nepavyko gauti sporto sakos: $e');
      return null;
    }
  }

  String? _mapSportIdToType(int? sportId) {
    switch (sportId) {
      case 1:
        return SportType.krepsinis;
      case 2:
        return SportType.futbolas;
      case 4:
        return SportType.tinklinis;
      default:
        return null;
    }
  }

  void selectAnswer(String value) {
    setState(() {
      answers[currentQuestion] = value;
    });
  }

  Future<void> goToNextQuestion() async {
    if (answers[currentQuestion] == null) return;

    if (currentQuestion < totalQuestions - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      await _submitTestResults();
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

  String _normalizeText(String value) {
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
      'Ą': 'a',
      'Č': 'c',
      'Ę': 'e',
      'Ė': 'e',
      'Į': 'i',
      'Š': 's',
      'Ų': 'u',
      'Ū': 'u',
      'Ž': 'z',
    };

    var normalized = value.toLowerCase().trim();
    replacements.forEach((from, to) {
      normalized = normalized.replaceAll(from, to);
    });

    normalized = normalized.replaceAll(RegExp(r'[^a-z0-9]+'), ' ');
    return normalized.trim();
  }

  double _calculateAverage(List<double> values) {
    if (values.isEmpty) return 0;
    final total = values.reduce((sum, item) => sum + item);
    return total / values.length;
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

  Future<void> _submitTestResults() async {
    if (isSubmitting) return;

    final user = supabase.auth.currentUser;
    if (user == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nepavyko rasti naudotojo')),
      );
      return;
    }

    setState(() {
      isSubmitting = true;
    });

    try {
      final Map<String, List<double>> scoreBuckets = {};

      for (var index = 0; index < _questions.length; index++) {
        final selectedAnswerId = answers[index];
        final entry = _questions[index];
        if (selectedAnswerId == null) continue;

        final selectedOption = entry.question.options.cast<QuestionOption?>().firstWhere(
          (option) => option?.id == selectedAnswerId,
          orElse: () => null,
        );

        if (selectedOption == null) continue;

        scoreBuckets.putIfAbsent(entry.categoryDbSkillName, () => []);
        scoreBuckets[entry.categoryDbSkillName]!.add(selectedOption.weight);
      }

      final skillDefinitions = await supabase
          .from('minkstieji_gebejimai')
          .select('id, pavadinimas');

      final currentSkillRows = await supabase
          .from('naudotojo_minkstieji')
          .select('id, fk_minkstieji_gebejimai, svoris')
          .eq('fk_naudotojas', user.id);

      final normalizedSkillIds = <String, int>{};
      for (final item in skillDefinitions as List) {
        final name = item['pavadinimas']?.toString();
        final id = item['id'] as int?;
        if (name == null || id == null) continue;
        normalizedSkillIds[_normalizeText(name)] = id;
      }

      final currentSkillMap = <int, Map<String, dynamic>>{};
      for (final item in currentSkillRows as List) {
        final skillId = item['fk_minkstieji_gebejimai'] as int?;
        if (skillId == null) continue;
        currentSkillMap[skillId] = Map<String, dynamic>.from(item);
      }

      for (final entry in scoreBuckets.entries) {
        final normalizedTitle = _normalizeText(entry.key);
        final skillId = normalizedSkillIds[normalizedTitle];
        if (skillId == null) {
          debugPrint('Nerastas įgūdžio ID kategorijai: ${entry.key}');
          continue;
        }

        final testScore = _calculateAverage(entry.value);
        final currentRow = currentSkillMap[skillId];
        final previousWeight = currentRow == null
            ? null
            : (currentRow['svoris'] as num?)?.toDouble();
        final newWeight = previousWeight == null
            ? testScore
            : (previousWeight * 0.7) + (testScore * 0.3);

        if (currentRow == null) {
          final nextCurrentId = await _getNextTableId('naudotojo_minkstieji');
          await supabase.from('naudotojo_minkstieji').insert({
            'id': nextCurrentId,
            'fk_naudotojas': user.id,
            'fk_minkstieji_gebejimai': skillId,
            'svoris': newWeight,
          });
        } else {
          await supabase
              .from('naudotojo_minkstieji')
              .update({'svoris': newWeight})
              .eq('id', currentRow['id']);
        }

        final nextHistoryId = await _getNextTableId(
          'naudotojo_minkstieji_history',
        );
        await supabase.from('naudotojo_minkstieji_history').insert({
          'id': nextHistoryId,
          'fk_naudotojas': user.id,
          'fk_minkstieji_gebejimai': skillId,
          'svoris': newWeight,
        });
      }

      await supabase.from('test_history').insert({
        'fk_naudotojas': user.id,
        'completed_at': DateTime.now().toIso8601String(),
      });

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Testo rezultatai išsaugoti')),
      );
      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nepavyko išsaugoti rezultatų: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSubmitting = false;
        });
      }
    }
  }

  Widget _buildOptionCard({
    required QuestionOption option,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: selected ? const Color.fromRGBO(56, 189, 248, 1) : Colors.white,
          border: Border.all(
            color: selected
                ? const Color.fromRGBO(56, 189, 248, 1)
                : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selected ? Colors.white : Colors.grey.shade200,
              ),
              child: Text(
                option.id.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected ? const Color.fromRGBO(56, 189, 248, 1) : Colors.black87,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                option.getText(userSportType),
                style: TextStyle(
                  fontSize: 16,
                  color: selected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    if (testUnavailable) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
          title: const Text('Testas'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_clock,
                  size: 90,
                  color: Color.fromRGBO(167, 139, 250, 1),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Testas jau atliktas',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Testą galėsite atlikti dar kartą po savaitės.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(11, 18, 32, 1),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(56, 189, 248, 1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Grįžti',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
          title: const Text('Testas'),
        ),
        body: const Center(
          child: Text('Klausimų kol kas nėra'),
        ),
      );
    }

    final progress = (currentQuestion + 1) / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: Text('Klausimas ${currentQuestion + 1} / $totalQuestions'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Image.asset(
              'assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
                final questionEntry = _questions[index];
                final question = questionEntry.question;
                final selectedAnswer = answers[index];

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Klausimas ${index + 1}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            question.getQuestionText(userSportType),
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 24),
                          ...question.options.map((option) {
                            final isSelected = selectedAnswer == option.id;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _buildOptionCard(
                                option: option,
                                selected: isSelected,
                                onTap: () => selectAnswer(option.id),
                              ),
                            );
                          }),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed:
                                      index == 0 ? null : goToPreviousQuestion,
                                  child: const Text('Atgal'),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: selectedAnswer == null || isSubmitting
                                      ? null
                                      : () async {
                                          await goToNextQuestion();
                                        },
                                  child: Text(
                                    index == totalQuestions - 1
                                        ? (isSubmitting ? 'Saugoma...' : 'Pateikti')
                                        : 'Kitas',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
