import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePagePassword extends StatefulWidget {
  final String password;

  const EditProfilePagePassword({
    super.key,
    required this.password
  });

  @override
  State<EditProfilePagePassword> createState() => _EditProfilePagePasswordState();
}

class _EditProfilePagePasswordState  extends State<EditProfilePagePassword> {
  final supabase = Supabase.instance.client;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController(text: "********");
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  Future<void> updatePassword() async {
    final newPassword = _newPasswordController.text.trim();
    final repeatPassword = _repeatPasswordController.text.trim();

    if (newPassword.isEmpty || repeatPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Užpildykite visus laukus")),
      );
      return;
    }

    if (newPassword != repeatPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Slaptažodžiai nesutampa")),
      );
      return;
    }

    try {
      await supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Slaptažodis pakeistas")),
      );

      Navigator.pop(context);

    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Klaida: ${e.message}")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Klaida: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          "Redaguoti slaptažodį",
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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7EB),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Jūsų Slaptažodis: ********",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF4F617F),
                ),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Naujas slaptažodis",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _repeatPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Pakartoti naują slaptažodį",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(56, 189, 248, 1)
              ),
              onPressed: updatePassword,
              child: const Text("Išsaugoti",
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