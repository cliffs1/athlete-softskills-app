import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InvitePlayerPage extends StatefulWidget {
  const InvitePlayerPage({super.key});

  @override
  State<InvitePlayerPage> createState() => _InvitePlayerPageState();
}

class _InvitePlayerPageState extends State<InvitePlayerPage> {
  final supabase = Supabase.instance.client;
  final emailController = TextEditingController();

  bool isLoading = false;

  Future<void> invitePlayer() async {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Įveskite el. paštą")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final userResponse = await supabase
          .from('naudotojas')
          .select()
          .eq('el_pastas', email)
          .maybeSingle();

      if (userResponse == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Naudotojas nerastas")),
        );
        return;
      }

      if (userResponse['role'] != 'player') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Galima kviesti tik žaidėjus")),
        );
        return;
      }


      final playerId = userResponse['auth_user_id'];
      final coachId = supabase.auth.currentUser!.id;

      final existingInvite = await supabase
          .from('kvietimai')
          .select()
          .eq('coach_id', coachId)
          .eq('player_id', playerId)
          .eq('status', 'pending')
          .maybeSingle();

      if (existingInvite != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Pakvietimas jau išsiųstas")),
        );
        return;
      }

      final acceptedInvite = await supabase
          .from('kvietimai')
          .select()
          .eq('coach_id', coachId)
          .eq('player_id', playerId)
          .eq('status', 'accepted')
          .maybeSingle();

      if (acceptedInvite != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Jau turite šitą žaidėją komandoje")),
        );
        return;
      }


      await supabase.from('kvietimai').insert({
        'coach_id': coachId,
        'player_id': playerId,
        'status': 'pending',
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Pakvietimas išsiųstas")),
      );

      emailController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Klaida: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Pakviesti žaidėją",
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Žaidėjo el. paštas",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading ? null : invitePlayer,
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text("Pakviesti"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}