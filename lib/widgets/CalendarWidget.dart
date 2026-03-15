import 'package:flutter/material.dart';
import 'package:softskills_app/pages/CalendarPage.dart';

class Calendarwidget extends StatelessWidget {
  const Calendarwidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
       onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Calendarpage(),
          ),
        );
      },
      icon: const Icon(Icons.calendar_today),
      label: const Text("Kalendorius"),
    );
  }
}