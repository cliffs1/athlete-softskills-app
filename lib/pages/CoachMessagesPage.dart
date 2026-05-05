import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CoachMessagesPage extends StatefulWidget {
  const CoachMessagesPage({super.key});
  @override
  State<CoachMessagesPage> createState() => _CoachMessagesPageState();
}

class _CoachMessagesPageState extends State<CoachMessagesPage> {
  final supabase = Supabase.instance.client;
  final messageController = TextEditingController();
  List<Map<String, dynamic>> players = [];
  String? selectedPlayerId;
  bool loading = true;
  bool sending = false;

  @override
  void initState() {
    super.initState();
    loadPlayers();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<void> loadPlayers() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('naudotojas')
        .select('auth_user_id, vardas, el_pastas')
        .eq('coach_id', user.id)
        .eq('role', 'player');

    setState(() {
      players = List<Map<String, dynamic>>.from(data);
      loading = false;
    });
  }

  Future<void> sendMessage() async {
    final user = supabase.auth.currentUser;
    if (user == null || selectedPlayerId == null) return;
    if (messageController.text.trim().isEmpty) return;

    setState(() => sending = true);

    try {
      await supabase.from('zinutes').insert({
        'treneris_id': user.id,
        'zaidejas_id': selectedPlayerId,
        'tekstas': messageController.text.trim(),
        'ar_perskaite': false,
      });

      messageController.clear();
      setState(() => selectedPlayerId = null);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Žinutė išsiųsta!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Klaida: $e')),
      );
    }

    setState(() => sending = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          'Trenerio žinutės',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: Image.asset(
              'assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedPlayerId,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Žaidėjas',
                    ),
                    hint: const Text('Pasirinkite žaidėją'),
                    items: players.map((player) {
                      return DropdownMenuItem<String>(
                        value: player['auth_user_id'],
                        child: Text(player['vardas'] ?? player['el_pastas']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedPlayerId = value);
                    },
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: messageController,
                    minLines: 5,
                    maxLines: 8,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                      labelText: 'Žinutė',
                      hintText: 'Įveskite žinutę',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: sending ? null : sendMessage,
                      child: sending
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Siųsti', style: TextStyle(fontSize: 16)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}