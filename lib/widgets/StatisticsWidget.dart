import 'package:flutter/material.dart';

class Statisticswidget extends StatelessWidget {
  const Statisticswidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.bar_chart),
      label: const Text("Statistika"),
    );
  }
}