import 'package:flutter/material.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/pages/WelcomePage.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'ProfilePage.dart';
import '../widgets/TipsWidget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
  super.initState();
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
                    'Menu',
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
              title: const Text('Profile'),
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
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomePage(),
                  ),
                );
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
            const SizedBox(height:10),
            TipsWidget(),
            const SizedBox(height:10),
            Calendarwidget(),
            const SizedBox(height:10),
            Statisticswidget(),
            const SizedBox(height:10),
          ],
        ),
      ),
    );
  }
}