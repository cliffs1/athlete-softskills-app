import 'package:flutter/material.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/pages/WelcomePage.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ProfilePage.dart';
import '../widgets/TipsWidget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final supabase = Supabase.instance.client;
  bool showMotivation = true;

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
        .select('show_motivation')
        .eq('auth_user_id', user.id)
        .single();

    setState(() {
      showMotivation = data['show_motivation'] ?? true;
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, showMotivation);
        return false;
      },
      child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Algora",
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
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height:10),
            SwitchListTile(
              title: const Text("Rodyti motyvaciją"),
              subtitle: const Text("Motyvacinės citatos pagrindiniame puslapyje"),
              value: showMotivation,
              onChanged: (value) async {
                setState(() {
                  showMotivation = value;
                });

                await updateMotivation(value);
              },
            ),
          ],
        ),
      ),
    ),
    );
  }
}