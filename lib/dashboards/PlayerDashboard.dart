import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
import '../widgets/CoachMessageNotificationWidget.dart';
import '../widgets/PremiumWidget.dart';

class PlayerDashboard extends StatefulWidget {
  final String playerId;
  final bool showMotivation;
  final String sport;

  const PlayerDashboard({
    super.key,
    required this.playerId,
    required this.showMotivation,
    required this.sport,
  });

  @override
  State<PlayerDashboard> createState() => _PlayerDashboardState();
}

class _PlayerDashboardState extends State<PlayerDashboard> {
  final supabase = Supabase.instance.client;

  String subscriptionType = 'free';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadSubscription();
  }

  Future<void> loadSubscription() async {
    final user = supabase.auth.currentUser;

    if (user == null) return;

    final data = await supabase
        .from('naudotojas')
        .select('subscription_type')
        .eq('auth_user_id', user.id)
        .single();

    setState(() {
      subscriptionType = data['subscription_type'] ?? 'free';
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            if (widget.showMotivation) ...[
              const SizedBox(height: 10),
              const MotivationWidget(),
            ],

            if (subscriptionType == 'free') ...[
              const SizedBox(height: 10),
              PremiumWidget(
                onPremiumActivated: loadSubscription,
              ),
            ],

            const SizedBox(height: 10),
            const DiaryReminderWidget(),

            const SizedBox(height: 10),
            const CoachMessageNotificationWidget(),

            const SizedBox(height: 10),
            const InviteReminderWidget(),

            const SizedBox(height: 10),
            const CompetitionReflectionReminderWidget(),

            const SizedBox(height: 10),
            const TipsWidget(),

            const SizedBox(height: 10),
            const CalendarWidget(),

            const SizedBox(height: 10),
            StatisticsWidget(
              playerId: widget.playerId,
              sport: widget.sport,
            ),

            const SizedBox(height: 10),
            const DiaryWidget(),

            const SizedBox(height: 10),
            const TestWidget(),

            // const SizedBox(height: 10),
            // const ShortTestWidget(),

            const SizedBox(height: 10),
            const BreathingWidget(),

          ],
        ),
      ),
    );
  }
}
