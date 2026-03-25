import 'package:flutter/material.dart';
import 'package:softskills_app/pages/CalendarPage.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

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
            builder: (context) => const Calendarpage(),
          ),
        );
      },
      icon: const Icon(Icons.calendar_today),
      label: const Text("Kalendorius"),
    ),
    );
  }
}