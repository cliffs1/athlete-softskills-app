import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final int totalQuestions = 10;
  final List<int?> answers = List<int?>.filled(10, null);

  late final PageController _pageController;
  int currentQuestion = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void selectAnswer(int value) {
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
      debugPrint('Answers: $answers');
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test completed')),
      );
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

  @override
  Widget build(BuildContext context) {
    final progress = (currentQuestion + 1) / totalQuestions;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
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
                return Padding(
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
                          const Text(
                            'Pavyzdinis klausimas.',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 32),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: List.generate(5, (choiceIndex) {
                              final value = choiceIndex + 1;
                              final selected = answers[index] == value;

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    answers[index] = value;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  width: 56,
                                  height: 56,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: selected
                                        ? Colors.blue
                                        : Colors.grey.shade200,
                                  ),
                                  child: Text(
                                    value.toString(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: selected
                                          ? Colors.white
                                          : Colors.black87,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                          const Spacer(),
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
                                  onPressed: answers[index] == null
                                      ? null
                                      : () async {
                                          await goToNextQuestion();
                                        },
                                  child: Text(
                                    index == totalQuestions - 1
                                        ? 'Pateikti'
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