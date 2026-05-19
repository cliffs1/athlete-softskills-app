import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlayerAnswersPage extends StatefulWidget {
  final String playerId;

  const PlayerAnswersPage({super.key, required this.playerId});

  @override
  State<PlayerAnswersPage> createState() => _PlayerAnswersPageState();
}

class _PlayerAnswersPageState extends State<PlayerAnswersPage> {
  final supabase = Supabase.instance.client;

  List<Map<String, dynamic>> entries = [];
  bool loading = true;

  final List<String> questions = [
    "Kaip šiandien jautėtės fiziškai ir emociškai?",
    "Ar šiandien bandėte pritaikyti minkštuosius įgūdžius?",
    "Kaip šiandien vertinate savo bendravimą ir atmosferą komandoje?",
  ];

  final List<List<String>> answerOptions = [
    [
      "Labai prastai",
      "Prastai",
      "Vidutiniškai",
      "Gerai",
      "Puikiai",
    ],
    [
      "Ne, visiškai nebandžiau",
      "Bandžiau labai mažai",
      "Kartais stengiausi pritaikyti",
      "Dažnai taikiau praktikoje",
      "Nuolat sąmoningai taikiau",
    ],
    [
      "Atmosfera buvo labai bloga",
      "Buvo nemažai įtampos",
      "Neutralu",
      "Atmosfera buvo gera",
      "Komandoje vyravo labai geras palaikymas ir bendravimas",
    ],
  ];

  @override
  void initState() {
    super.initState();
    loadDiary();
  }

  Future<void> loadDiary() async {
    final data = await supabase
        .from('dienorastis')
        .select('*')
        .eq('user_id', widget.playerId)
        .order('entry_date', ascending: false)
        .limit(7);

    setState(() {
      entries = List<Map<String, dynamic>>.from(data);
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (entries.isEmpty) {
      return const Center(
        child: Text("Nėra dienoraščio įrašų"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: entries.length,
      itemBuilder: (context, index) {
        final e = entries[index];

        final answers = [
          e['q1'],
          e['q2'],
          e['q3'],
        ];

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ExpansionTile(
              title: Text("📅 ${e['entry_date']}"),
            children: [
              ...List.generate(3, (i) {
                final int? answerIndex = answers[i];

                final answerText = (answerIndex == null ||
                    answerIndex < 0 ||
                    answerIndex >= answerOptions[i].length)
                    ? "-"
                    : answerOptions[i][answerIndex];

                return ListTile(
                  title: Text(questions[i]),
                  subtitle: Text(answerText),
                );
              }),

              if (e['ai_tip'] != null)
                ListTile(
                  title: const Text("AI patarimas"),
                  subtitle: Text(e['ai_tip']),
                ),
            ],
          ),
        );
      },
    );
  }
}