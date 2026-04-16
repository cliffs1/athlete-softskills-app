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
        };
        for (int i = 0; i < answers.length; i++) {
          data['q${i + 1}'] = answers[i];
        }
        await supabase.from('dienorastis').insert(data);

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