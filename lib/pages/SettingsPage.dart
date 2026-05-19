import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final supabase = Supabase.instance.client;

  bool showMotivation = true;
  String role = 'player';
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  Future<void> loadSettings() async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    final data = await supabase
        .from('naudotojas')
        .select('show_motivation, role, subscription_type')
        .eq('auth_user_id', user.id)
        .single();

    setState(() {
      showMotivation = data['show_motivation'] ?? true;
      role = data['role'] ?? 'player';
      isPremium = data['subscription_type'] == 'premium';
    });
  }

  Future<void> updateMotivation(bool value) async {
    final user = supabase.auth.currentUser;
    if (user == null) return;

    await supabase
        .from('naudotojas')
        .update({'show_motivation': value})
        .eq('auth_user_id', user.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          'Algora',
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            SwitchListTile(
              title: const Text('Rodyti motyvaciją'),
              subtitle: const Text(
                'Motyvacinės citatos pagrindiniame puslapyje',
              ),
              value: showMotivation,
              onChanged: (value) async {
                setState(() {
                  showMotivation = value;
                });

                await updateMotivation(value);
              },
            ),
            if (isPremium) ...[
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: role,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Rolė",
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'player',
                    child: Text('Žaidėjas'),
                  ),
                  DropdownMenuItem(
                    value: 'coach',
                    child: Text('Treneris'),
                  ),
                ],
                onChanged: (value) async {
                  if (value == null) return;

                  setState(() {
                    role = value;
                  });

                  await supabase
                      .from('naudotojas')
                      .update({'role': value})
                      .eq('auth_user_id', supabase.auth.currentUser!.id);
                },
              ),
            ]
          ],

        ),
      ),
    );
  }
}