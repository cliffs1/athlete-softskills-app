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

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Dienoraštis",
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
            const SizedBox(height: 10),
            Text('Dienoraštis')
          ],
        ),
      ),
    );
  }
}