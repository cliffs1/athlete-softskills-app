import 'package:flutter/material.dart';
import 'dart:io';
import 'ProfilePageEdit.dart';
import 'ProfilePageEditPassword.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final supabase = Supabase.instance.client;

  String username = "";
  String email = "";
  String password = ""; // ne tikras slaptazodis bus
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final user = supabase.auth.currentUser;

    if (user == null) return;

    try {
      final data = await supabase
          .from('naudotojas')
          .select()
          .eq('auth_user_id', user.id)
          .maybeSingle();

      setState(() {
        username = data?['vardas'] ?? "Be vardo";
        email = user.email ?? "Be el. pašto";
        password = "********"; // hard coded :p
        isLoading = false;
      });
    } catch (e) {
      print("Error loading profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Profilis",
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? const Icon(Icons.person, size: 35)
                        : null,
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Text(
                      username,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfilePage(
                            username: username,
                            image: _image,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Jūsų el. paštas: $email",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4F617F),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Jūsų slaptažodis: $password",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4F617F),
                ),
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(56, 189, 248, 1)
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfilePagePassword(
                        password: password
                      )
                  )
                );
              },
              child: const Text("Keisti slaptažodį",
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(255, 255, 255, 1))
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(56, 189, 248, 1)
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ištrinti paskyrą",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1))
              ),
            )
          ],
        ),
      ),
    );
  }
}