import 'package:flutter/material.dart';
import '../data/diary_AI.dart';

class CoachResultPage extends StatelessWidget {
  final CoachResponse response;
  const CoachResultPage({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "AI Coach analizė",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Image.asset('assets/brain_logo_goodremakecolor.png', height: 60),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Row(children: [
            const Icon(Icons.psychology, color: Color.fromRGBO(167, 139, 250, 1)),
            const SizedBox(width: 8),
            const Text(
              "Šiandienos apžvalga",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ]),
          const SizedBox(height: 16),

          Text(
            response.summary,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
          const SizedBox(height: 16),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(167, 139, 250, 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color.fromRGBO(167, 139, 250, 0.3)),
            ),
            child: Text(
              response.analysis,
              style: const TextStyle(fontSize: 14, height: 1.6),
            ),
          ),
          const SizedBox(height: 20),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(56, 189, 248, 0.08),
              borderRadius: BorderRadius.circular(16),
              border: const Border(
                left: BorderSide(color: Color.fromRGBO(56, 189, 248, 1), width: 3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Rytojaus tikslas",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(56, 189, 248, 1),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  response.tomorrowTip,
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text("Uždaryti", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}