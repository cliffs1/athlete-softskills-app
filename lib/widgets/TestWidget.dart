import 'package:flutter/material.dart';
import 'package:softskills_app/pages/TestPage.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

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
              builder: (context) => const TestPage(),
            ),
          );
        },
        icon: const Icon(Icons.accessibility),
        label: const Text("Testas"),
      ),
    );
  }
}