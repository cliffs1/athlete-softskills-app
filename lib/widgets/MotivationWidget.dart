import 'dart:math';

import 'package:softskills_app/data/motivation_messages.dart';
import 'package:flutter/material.dart';

class MotivationWidget extends StatefulWidget {
  const MotivationWidget({super.key});

  @override
  State<MotivationWidget> createState() => _MotivationWidgetState();
}

class _MotivationWidgetState extends State<MotivationWidget> {
  late String todayMessage;

  @override
  void initState() {
    super.initState();
    todayMessage = getDailyMessage();
  }

  String getDailyMessage() {
    final now = DateTime.now();
    final seed = now.year + now.month + now.day;
    final random = Random(seed);
    return motivationMessages[random.nextInt(motivationMessages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(237, 233, 254, 1),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.lightbulb,
            color: Color.fromRGBO(124, 58, 237, 1),
            size: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              todayMessage,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
