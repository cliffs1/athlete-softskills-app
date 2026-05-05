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
  final String playerId;

  const PlayerDashboard({super.key, required this.playerId});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const MotivationWidget(),
          const SizedBox(height: 10),
          const DiaryReminderWidget(),
          const SizedBox(height:10),
          const CompetitionReflectionReminderWidget(),
          const SizedBox(height:10),
          const TipsWidget(),
          const SizedBox(height:10),
          const CalendarWidget(),
          const SizedBox(height:10),
          StatisticsWidget(playerId: playerId),
          const SizedBox(height:10),
          const DiaryWidget(),
          const SizedBox(height:10),
          const TestWidget(),
          const SizedBox(height:10),
          const BreathingWidget(),
        ],
      ),
    );
  }
}