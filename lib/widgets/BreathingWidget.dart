import 'package:flutter/material.dart';
import '../pages/BreathingPage.dart';
 
class BreathingWidget extends StatelessWidget {
  const BreathingWidget({super.key});
 
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
              builder: (context) => const BreathingPage(),
            ),
          );
        },
        icon: const Icon(Icons.air),
        label: const Text('Kvėpavimo pratimas'),
      ),
    );
  }
}