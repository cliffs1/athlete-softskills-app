import 'package:flutter/material.dart';

import '../pages/CoachMessagesPage.dart';
import '../widgets/PlayerListWidget.dart';

class CoachDashboard extends StatelessWidget {
  const CoachDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Mano žaidėjai',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CoachMessagesPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.message_outlined),
                label: const Text('Siųsti žinutę'),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const PlayerListWidget(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
