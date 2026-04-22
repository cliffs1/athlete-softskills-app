import 'package:flutter/material.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:softskills_app/widgets/TestWidget.dart';
import '../widgets/TipsWidget.dart';
import '../widgets/MotivationWidget.dart';
import '../widgets/DiaryWidget.dart';
import '../widgets/DiaryReminderWidget.dart';
import '../widgets/CompetitionReflectionReminderWidget.dart';
import '../widgets/BreathingWidget.dart';


class PlayerDashboard extends StatelessWidget {
  const PlayerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const [
          SizedBox(height: 10),
          MotivationWidget(),
          SizedBox(height: 10),
          DiaryReminderWidget(),
          SizedBox(height:10),
          CompetitionReflectionReminderWidget(),
          SizedBox(height:10),
          TipsWidget(),
          SizedBox(height:10),
          CalendarWidget(),
          SizedBox(height:10),
          StatisticsWidget(),
          SizedBox(height:10),
          DiaryWidget(),
          SizedBox(height:10),
          TestWidget(),
          SizedBox(height:10),
          BreathingWidget(),
        ],
      ),
    );
  }
}