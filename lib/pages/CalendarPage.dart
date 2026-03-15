import 'package:flutter/material.dart';

class Calendarpage extends StatelessWidget {
  const Calendarpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kalendorius'),
      ),
      body: const Center(
        child: Text(
          'Kalendorius',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}