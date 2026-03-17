import 'package:flutter/material.dart';

class Calendarpage extends StatelessWidget {
  const Calendarpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Kalendorius",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Image.asset(
              '../../android/assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
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