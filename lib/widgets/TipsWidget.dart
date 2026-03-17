import 'package:flutter/material.dart';
import 'package:softskills_app/pages/TipsPage.dart';

class TipsWidget extends StatelessWidget {
  const TipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TipsPage(),
            ),
          );
        },
        icon: const Icon(Icons.lightbulb),
        label: const Text("Patarimai"),
      ),
    );
  }
}