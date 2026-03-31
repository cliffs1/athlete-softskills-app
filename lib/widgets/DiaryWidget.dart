import 'package:flutter/material.dart';
import 'package:softskills_app/pages/DiaryPage.dart';

class DiaryWidget extends StatelessWidget {
  const DiaryWidget({super.key});

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
              builder: (context) => const DiaryPage(),
            ),
          );
        },
        icon: const Icon(Icons.account_balance_wallet_rounded),
        label: const Text("Dienoraštis"),
      ),
    );
  }
}