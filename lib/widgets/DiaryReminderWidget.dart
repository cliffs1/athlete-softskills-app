import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../pages/DiaryPage.dart';

class DiaryReminderWidget extends StatefulWidget {
  const DiaryReminderWidget({super.key});

  @override
  State<DiaryReminderWidget> createState() => _DiaryReminderWidgetState();
}

class _DiaryReminderWidgetState extends State<DiaryReminderWidget> {
  final supabase = Supabase.instance.client;

  bool? showReminder;

  @override
  void initState() {
    super.initState();
    checkDiary();
  }

  Future<void> checkDiary() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final today = DateTime.now().toIso8601String().split('T')[0];

    final response = await supabase
        .from('dienorastis')
        .select()
        .eq('user_id', user.id)
        .eq('entry_date', today);

    setState(() {
      showReminder = response.isEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showReminder == null || showReminder == false) {
      return const SizedBox();
    }

    return GestureDetector(
      onTap: () async {
        final result = await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DiaryPage()),
        );

        if (result == true) {
          await checkDiary();
        }
      },
      child: Container(
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange.shade200),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.edit_note, color: Colors.orange, size: 30),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Užpildyk šiandienos dienoraštį ✍️",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16)
          ],
        ),
      ),
    );
  }
}