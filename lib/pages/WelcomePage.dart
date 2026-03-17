import 'package:flutter/material.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'ProfilePage.dart';
import '../widgets/TipsWidget.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
  }

  bool isChecked = false;

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
              '../../android/assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height:20),
            const Text("Sveiki *user*!", style: TextStyle(
              fontSize: 30,
              )
            ),
            const SizedBox(height:20),
            const Text("Šita programėlė yra skirta tau tobulinti minkštuosius įgudžius.", style: TextStyle(
              fontSize: 20,
            ), textAlign: TextAlign.center,
            ),
            const SizedBox(height:5),
            const Text("Joje galėsi įsivertinti savo įgūdžius atlikus testuką. "
                "Po to gali sekti savo progresą ir tikrinti savo įgudžių vertinimus.", style: TextStyle(
              fontSize: 20,
            ), textAlign: TextAlign.center,
            ),
            const SizedBox(height:80),
            ElevatedButton(
              onPressed: () { Navigator.pop(context); },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(56, 189, 248, 1),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                'Tęsti',
                style: TextStyle(fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                  value: isChecked,
                  onChanged: (bool? value) {
                    setState(() {
                      isChecked = value!;
                    });
                  },
                ),
                const Text("Nerodyti daugiau"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}