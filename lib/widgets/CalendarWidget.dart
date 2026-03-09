import 'package:flutter/material.dart';

class Calendarwidget extends StatelessWidget {
  const Calendarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.calendar_today),
      label: const Text("Kalendorius"),
    );
  }
}