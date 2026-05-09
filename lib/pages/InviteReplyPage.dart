import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InviteReplyPage extends StatefulWidget {
  const InviteReplyPage({super.key});

  @override
  State<InviteReplyPage> createState() => _InviteReplyPageState();
}

class _InviteReplyPageState extends State<InviteReplyPage> {
  final supabase = Supabase.instance.client;
  List invites = [];

  @override
  void initState() {
    super.initState();
    fetchInvites();
  }

  Future<void> fetchInvites() async {
    final user = supabase.auth.currentUser;

    final response = await supabase
        .from('kvietimai')
        .select('id, coach_id, naudotojas!fk_coach(vardas)')
        .eq('player_id', user!.id)
        .eq('status', 'pending');

    setState(() {
      invites = response;
    });
  }

  Future<void> updateInvite(String id, String status) async {
    await supabase
        .from('kvietimai')
        .update({'status': status})
        .eq('id', id);

    fetchInvites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Kvietimai",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0.0),
            child: Image.asset(
              'assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: invites.length,
        itemBuilder: (context, index) {
          final invite = invites[index];
          final coachName = invite['naudotojas']['vardas'];

          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text("$coachName pakvietė jus"),
              subtitle: const Text("Prisijungti prie komandos?"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.check, color: Colors.green),
                    onPressed: () => updateInvite(invite['id'], 'accepted'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: () => updateInvite(invite['id'], 'rejected'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}