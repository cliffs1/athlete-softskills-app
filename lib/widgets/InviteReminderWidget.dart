import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../pages/InviteReplyPage.dart';

class InviteReminderWidget extends StatefulWidget {
  const InviteReminderWidget({super.key});

  @override
  State<InviteReminderWidget> createState() => _InviteReminderWidgetState();
}

class _InviteReminderWidgetState extends State<InviteReminderWidget> {
  final supabase = Supabase.instance.client;

  List invites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchInvites();
  }

  Future<void> fetchInvites() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final response = await supabase
        .from('kvietimai')
        .select('id, coach_id, naudotojas!fk_coach(vardas)')
        .eq('player_id', user.id)
        .eq('status', 'pending');

    setState(() {
      invites = response;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading || invites.isEmpty) {
      return const SizedBox();
    }

    final coachName = (invites.isNotEmpty &&
        invites.first['naudotojas'] != null)
        ? (invites.first['naudotojas'] is List
        ? invites.first['naudotojas'][0]['vardas']
        : invites.first['naudotojas']['vardas'])
        : 'Treneris';

    return GestureDetector(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const InviteReplyPage()),
        );

        fetchInvites(); // refresh after returning
      },
      child: Container(
        width: 350,
        margin: const EdgeInsets.symmetric(horizontal: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.shade200),
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
            const Icon(Icons.mail, color: Colors.blue, size: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "$coachName pakvietė jus į komandą",
                style: const TextStyle(
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