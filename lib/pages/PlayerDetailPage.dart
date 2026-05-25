import 'package:flutter/material.dart';
import '../widgets/StatisticsWidget.dart';
import '../pages/StatisticsPage.dart';
import '../pages/PlayerAnswersPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlayerDetailPage extends StatelessWidget {
  final Map<String, dynamic> player;

  const PlayerDetailPage({super.key, required this.player});


  Future<List<Map<String, dynamic>>> fetchDiary() async {
    final supabase = Supabase.instance.client;

    final data = await supabase
        .from('dienorastis')
        .select('*')
        .eq('user_id', player['auth_user_id'])
        .order('entry_date', ascending: false)
        .limit(7);

    return List<Map<String, dynamic>>.from(data);
  }

  @override
  Widget build(BuildContext context) {
    final playerId = player['auth_user_id'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
          title: Text(
            player['vardas'] ?? 'Žaidėjas',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: [
            Image.asset('assets/brain_logo_goodremakecolor.png', height: 60),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(text: "Statistika"),
              Tab(text: "Atsakymai"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            Statisticspage(playerId: playerId, showAppBar: false),
            PlayerAnswersPage(playerId: player['auth_user_id']),
          ],
        ),
      ),
    );
  }
}