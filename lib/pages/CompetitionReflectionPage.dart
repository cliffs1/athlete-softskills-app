import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompetitionReflectionPage extends StatefulWidget {
  const CompetitionReflectionPage({
    super.key,
    required this.eventId,
    required this.eventTitle,
    required this.eventDate,
  });

  final int eventId;
  final String eventTitle;
  final DateTime eventDate;

  @override
  State<CompetitionReflectionPage> createState() =>
      _CompetitionReflectionPageState();
}

class _CompetitionReflectionPageState
    extends State<CompetitionReflectionPage> {
  final supabase = Supabase.instance.client;

  final List<String> _scaleQuestions = [
    'Kaip vertini savo pasirengimą šiandienos varžyboms?',
    'Kaip tau sekėsi valdyti stresą varžybų metu?',
    'Kaip vertini savo susikaupimą ir dėmesio išlaikymą?',
    'Kaip jautiesi po šiandienos pasirodymo?',
  ];

  late final List<int?> _answers;
  late final PageController _pageController;
  final TextEditingController _textController = TextEditingController();

  bool? _completed;
  int _currentQuestion = 0;
  String _reflectionText = '';

  int get _totalQuestions => _scaleQuestions.length + 1;

  @override
  void initState() {
    super.initState();
    _answers = List<int?>.filled(_scaleQuestions.length, null);
    _pageController = PageController();
    _checkIfCompleted();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _checkIfCompleted() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('event_reflections')
        .select('id')
        .eq('user_id', user.id)
        .eq('event_id', widget.eventId);

    if (!mounted) return;
    setState(() {
      _completed = response.isNotEmpty;
    });
  }

  Future<void> _goToNextQuestion() async {
    if (_currentQuestion < _totalQuestions - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      await supabase.from('event_reflections').insert({
        'event_id': widget.eventId,
        'user_id': user.id,
        'reflection_date': DateTime.now().toIso8601String().split('T')[0],
        'preparation_rating': _answers[0],
        'stress_management_rating': _answers[1],
        'focus_rating': _answers[2],
        'post_event_feeling_rating': _answers[3],
        'reflection_text': _reflectionText.trim(),
      });

      if (!mounted) return;
      setState(() {
        _completed = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Refleksija išsaugota')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Klaida: $e')),
      );
    }
  }

  Future<void> _goToPreviousQuestion() async {
    if (_currentQuestion == 0) return;

    await _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool _canProceed(int index) {
    if (index < _scaleQuestions.length) {
      return _answers[index] != null;
    }

    return _reflectionText.trim().isNotEmpty;
  }

  int _wordCount(String text) {
    return text.trim().isEmpty ? 0 : text.trim().split(RegExp(r'\s+')).length;
  }

  String _formattedDate() {
    return '${widget.eventDate.day}-${widget.eventDate.month}-${widget.eventDate.year}';
  }

  Widget _buildScaleQuestion(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Klausimas ${index + 1}',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Text(
          _scaleQuestions[index],
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 32),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: List.generate(5, (choiceIndex) {
            final value = choiceIndex + 1;
            final selected = _answers[index] == value;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _answers[index] = value;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 56,
                height: 56,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: selected ? Colors.blue : Colors.grey.shade200,
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
        const SizedBox(height: 16),
        const Text(
          '1 - labai silpnai, 5 - labai gerai',
          style: TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        _navigationButtons(index),
      ],
    );
  }

  Widget _buildTextQuestion() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Kas šiandien pavyko geriausiai ir ką kitą kartą norėtum daryti kitaip?',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _textController,
          maxLines: 7,
          onChanged: (value) {
            if (_wordCount(value) <= 200) {
              setState(() {
                _reflectionText = value;
              });
            }
          },
          decoration: const InputDecoration(
            hintText: 'Parašyk iki 200 žodžių...',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Žodžiai: ${_wordCount(_textController.text)} / 200',
          style: const TextStyle(color: Colors.grey),
        ),
        const Spacer(),
        _navigationButtons(_scaleQuestions.length),
      ],
    );
  }

  Widget _navigationButtons(int index) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: index == 0 ? null : _goToPreviousQuestion,
            child: const Text('Atgal'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _canProceed(index) ? _goToNextQuestion : null,
            child: Text(index == _totalQuestions - 1 ? 'Išsaugoti' : 'Kitas'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = (_currentQuestion + 1) / _totalQuestions;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          'Vakaro refleksija',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
      body: _completed == null
          ? const Center(child: CircularProgressIndicator())
          : _completed!
              ? Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle, color: Colors.green),
                        const SizedBox(width: 10),
                        Text(
                          'Šios dienos refleksiją jau užpildei',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LinearProgressIndicator(value: progress),
                          const SizedBox(height: 16),
                          Text(
                            '${widget.eventTitle} • ${_formattedDate()}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Skirk kelias minutes įsivertinti savo patirtį po varžybų.',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _totalQuestions,
                        onPageChanged: (index) {
                          setState(() {
                            _currentQuestion = index;
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
                                child: index < _scaleQuestions.length
                                    ? _buildScaleQuestion(index)
                                    : _buildTextQuestion(),
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
