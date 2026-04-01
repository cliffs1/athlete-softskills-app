import 'package:flutter/material.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:softskills_app/widgets/TestWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ProfilePage.dart';
import '../widgets/TipsWidget.dart';
import '../widgets/MotivationWidget.dart';
import 'SettingsPage.dart';
import '../widgets/DiaryWidget.dart';
import '../widgets/DiaryReminderWidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final supabase = Supabase.instance.client;
  bool showMotivation = true;

  @override
  void initState() {
  super.initState();
  loadSettings();
  //testDatabase();
  }

 Future<void> testDatabase() async {
  try {
    debugPrint('testDatabase started');

    final data = await supabase.from('sporto_saka').select();

    debugPrint('Query finished');
    debugPrint('Rows count: ${data.length}');
    debugPrint('Data: $data');
  } catch (e) {
    debugPrint('Database error: $e');
  }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 70,
              child: const DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(167, 139, 250, 1),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Meniu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profilis'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Nustatymai'),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
                if (result != null) {
                  setState(() {
                    showMotivation = result;
                  });
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Atsijungti'),
              onTap: () async {
                await supabase.auth.signOut();

                if (!mounted) return;

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                      (route) => false,
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 10),
            if (showMotivation) MotivationWidget(),
            const SizedBox(height: 10),
            DiaryReminderWidget(),
            const SizedBox(height:10),
            TipsWidget(),
            const SizedBox(height:10),
            CalendarWidget(),
            const SizedBox(height:10),
            StatisticsWidget(),
            const SizedBox(height:10),
            DiaryWidget(),
            const SizedBox(height:10),
            TestWidget(),
            const SizedBox(height:10),
          ],
        ),
      ),
    );
  }
}