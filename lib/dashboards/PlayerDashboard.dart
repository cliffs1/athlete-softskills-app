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
import '../widgets/InviteReminderWidget.dart';


class PlayerDashboard extends StatelessWidget {
  final String playerId;
  final bool showMotivation;

  const PlayerDashboard({super.key, required this.playerId, required this.showMotivation});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            if (showMotivation) ...[
              const SizedBox(height: 10),
              const MotivationWidget(),
            ],
            const SizedBox(height: 10),
            const DiaryReminderWidget(),
            const SizedBox(height: 10),
            const InviteReminderWidget(),
            const SizedBox(height: 10),
            const CompetitionReflectionReminderWidget(),
            const SizedBox(height: 10),
            const TipsWidget(),
            const SizedBox(height: 10),
            const CalendarWidget(),
            const SizedBox(height: 10),
            StatisticsWidget(playerId: playerId),
            const SizedBox(height: 10),
            const DiaryWidget(),
            const SizedBox(height: 10),
            const TestWidget(),
            const SizedBox(height: 10),
            const BreathingWidget(),
          ],
        ),
      ),
    );
  }
}