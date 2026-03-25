import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final File? image;

  const EditProfilePage({
    super.key,
    required this.username,
    required this.image,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _image = widget.image;
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<void> updateProfile() async {
    final user = supabase.auth.currentUser;

    if (user == null) return;

    try {
      await supabase
          .from('naudotojas')
          .update({
        'vardas': _usernameController.text,
      })
          .eq('auth_user_id', user.id);

      if (!mounted) return;

      Navigator.pop(context, {
        "vardas": _usernameController.text,
        "image": _image
      });

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
          "Redaguoti profilį",
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

            CircleAvatar(
              radius: 60,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(56, 189, 248, 1)
              ),
              onPressed: _pickImage,
              child: const Text("Keisti nuotrauką",
                  style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(255, 255, 255, 1))
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: "Naudotojo vardas",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(56, 189, 248, 1)
              ),
              onPressed: updateProfile,
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