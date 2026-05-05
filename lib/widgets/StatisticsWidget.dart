import 'package:flutter/material.dart';
import 'package:softskills_app/pages/StatisticsPage.dart';

class StatisticsWidget extends StatelessWidget {
  final String playerId;

  const StatisticsWidget({super.key, required this.playerId});

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
            builder: (context) => Statisticspage(playerId: playerId),
          ),
        );
      },
      icon: const Icon(Icons.bar_chart),
      label: const Text("Statistika"),
    ),
    );
  }
}