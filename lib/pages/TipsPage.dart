import 'package:flutter/material.dart';

class TipsPage extends StatelessWidget {
  const TipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rekomendacijos'),
      ),
      body: const Center(
        child: Text(
          'Rekomendacijos',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}