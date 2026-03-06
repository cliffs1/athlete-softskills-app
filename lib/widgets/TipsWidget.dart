import 'package:flutter/material.dart';

class TipsWidget extends StatelessWidget {
  const TipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.lightbulb),
      label: const Text("Patarimai"),
    );
  }
}