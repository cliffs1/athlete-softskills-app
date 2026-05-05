import 'package:flutter/material.dart';
import '../widgets/StatisticsWidget.dart';
import '../pages/StatisticsPage.dart';

class PlayerDetailPage extends StatelessWidget {
  final Map<String, dynamic> player;

  const PlayerDetailPage({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    final playerId = player['auth_user_id'];

    return DefaultTabController(
      length: 3,
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
              Tab(text: "Apžvalga"),
              Tab(text: "Statistika"),
              Tab(text: "Kita"),
            ],
          ),
        ),

        body: TabBarView(
          children: [
            _buildOverviewTab(player),
            Statisticspage(playerId: playerId),
            const Center(child: Text("Coming soon")),
          ],
        ),
      ),
    );
  }

  static Widget _buildOverviewTab(Map<String, dynamic> player) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            player['vardas'] ?? 'Be vardo',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          Text("El. paštas: ${player['el_pastas'] ?? '-'}"),
          const SizedBox(height: 10),

          Text("ID: ${player['id']}"),

          const SizedBox(height: 20),
          const Divider(),

          const Text(
            "Papildoma informacija",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}