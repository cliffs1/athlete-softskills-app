import 'dart:math';
import 'package:flutter/material.dart';

class MotivationWidget extends StatefulWidget {
  const MotivationWidget({super.key});

  @override
  State<MotivationWidget> createState() => _MotivationWidgetState();
}

class _MotivationWidgetState extends State<MotivationWidget> {
final List<String> messages = [
  'Klausymas yra stiprybė, ne silpnybė.',
  'Kiekvienas pokalbis yra galimybė gerinti komunikaciją.',
  'Empatija prasideda nuo noro suprasti kitą.',
  'Tavo reakcijos formuoja tavo santykius.',
  'Kantrybė yra viena svarbiausių lyderio savybių.',
  'Konstruktyvus grįžtamasis ryšys kuria augimą.',
  'Komandinis darbas prasideda nuo pasitikėjimo.',
  'Gebėjimas prisitaikyti yra raktas į sėkmę.',
  'Klaidos yra mokymosi proceso dalis.',
  'Aiški komunikacija sumažina nesusipratimus.',
  'Kritinis mąstymas padeda priimti geresnius sprendimus.',
  'Savęs pažinimas yra pirmas žingsnis į tobulėjimą.',
  'Lyderystė prasideda nuo atsakomybės už save.',
  'Kiekviena diena yra proga tapti geresniu komandos nariu.',
  'Emocinis intelektas stiprina ryšius su kitais.',
  'Drąsa išsakyti mintis yra augimo dalis.',
  'Klausimai yra svarbesni nei greiti atsakymai.',
  'Maži patobulinimai kasdien sukuria didelį progresą.',
];

  late String todayMessage;

  @override
  void initState() {
    super.initState();
    todayMessage = getDailyMessage();
  }

  String getDailyMessage() {
    final now = DateTime.now();
    final seed = now.year + now.month + now.day;
    final random = Random(seed);
    return messages[random.nextInt(messages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 233, 254, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb,
            color: Color.fromRGBO(124, 58, 237, 1),
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              todayMessage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}