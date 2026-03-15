import 'package:flutter/material.dart';

class Statisticspage extends StatelessWidget {
  const Statisticspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistika'),
      ),
      body: const Center(
        child: Text(
          'Statistika',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}