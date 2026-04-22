import 'package:flutter/material.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:softskills_app/widgets/TestWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/TipsWidget.dart';
import '../widgets/MotivationWidget.dart';
import '../widgets/DiaryWidget.dart';
import '../widgets/DiaryReminderWidget.dart';
import '../widgets/CompetitionReflectionReminderWidget.dart';
import '../widgets/BreathingWidget.dart';
import '../dashboards/PlayerDashboard.dart';
import '../dashboards/CoachDashboard.dart';

class PlayerListWidget extends StatefulWidget {
  const PlayerListWidget({super.key});

  @override
  State<PlayerListWidget> createState() => _PlayerListWidgetState();
}

class _PlayerListWidgetState extends State<PlayerListWidget> {
  final supabase = Supabase.instance.client;

  List<dynamic> players = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPlayers();
  }

  Future<void> fetchPlayers() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    try {
      final data = await supabase
          .from('naudotojas')
          .select()
          .eq('coach_id', user.id);

      setState(() {
        players = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (players.isEmpty) {
      return const Center(child: Text("Neturite priskirtų žaidėjų"));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(player['vardas'] ?? 'Be vardo'),
            subtitle: Text(player['el_pastas'] ?? ''),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              // later → navigate to PlayerDetailPage
            },
          ),
        );
      },
    );
  }
}
