import 'package:flutter/material.dart';
import 'package:softskills_app/pages/StatisticsPage.dart';

class Statisticswidget extends StatelessWidget {
  const Statisticswidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Statisticspage(),
          ),
        );
      },
      icon: const Icon(Icons.bar_chart),
      label: const Text("Statistika"),
    );
  }
}