import 'package:flutter/material.dart';
import '../widgets/PlayerListWidget.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:softskills_app/widgets/TestWidget.dart';
import '../widgets/TipsWidget.dart';
import '../widgets/MotivationWidget.dart';
import '../widgets/DiaryWidget.dart';
import '../widgets/DiaryReminderWidget.dart';
import '../widgets/CompetitionReflectionReminderWidget.dart';
import '../widgets/BreathingWidget.dart';

class CoachDashboard extends StatelessWidget {
  const CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          SizedBox(height: 20),

          Text(
            "Mano žaidėjai",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          SizedBox(height: 10),

          PlayerListWidget(),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}