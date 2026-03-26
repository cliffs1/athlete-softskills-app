import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EditProfilePage extends StatefulWidget {
  final String username;
  final String? profilePicPath;

  const EditProfilePage({
    super.key,
    required this.username,
    this.profilePicPath,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;

  final ImagePicker _picker = ImagePicker();
  final supabase = Supabase.instance.client;

  Uint8List? _imageBytes;
  String? _currentProfilePicPath;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.username);
    _currentProfilePicPath = widget.profilePicPath;
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedImage == null) return;

      final bytes = await pickedImage.readAsBytes();

      setState(() {
        _imageBytes = bytes;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nepavyko pasirinkti nuotraukos: $e')),
      );
    }
  }

  String? _getProfileImageUrl() {
    if (_currentProfilePicPath == null || _currentProfilePicPath!.isEmpty) {
      return null;
    }

    return supabase.storage
        .from('profile_pictures')
        .getPublicUrl(_currentProfilePicPath!);
  }

  Future<void> updateProfile() async {
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Naudotojas neprisijungęs')),
      );
      return;
    }

    final username = _usernameController.text.trim();

    if (username.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Įveskite naudotojo vardą')),
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    try {
      String? profilePicPath = _currentProfilePicPath;

      if (_imageBytes != null) {
        profilePicPath = '${user.id}/profile.jpg';

        await supabase.storage.from('profile_pictures').uploadBinary(
          profilePicPath,
          _imageBytes!,
          fileOptions: const FileOptions(
            cacheControl: '3600',
            upsert: true,
          ),
        );
      }

      await supabase.from('naudotojas').update({
        'vardas': username,
        'profile_pic_path': profilePicPath,
      }).eq('auth_user_id', user.id);

      if (!mounted) return;

      Navigator.pop(context, {
        'vardas': username,
        'profile_pic_path': profilePicPath,
        'image_bytes': _imageBytes,
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Klaida: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImageUrl = _getProfileImageUrl();

    ImageProvider? avatarProvider;
    if (_imageBytes != null) {
      avatarProvider = MemoryImage(_imageBytes!);
    } else if (profileImageUrl != null) {
      avatarProvider = NetworkImage(profileImageUrl);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          'Redaguoti profilį',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: Image.asset(
                  'assets/brain_logo_goodremakecolor.png',
                  fit: BoxFit.contain,
                ),
              ),
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
              backgroundImage: avatarProvider,
              child: avatarProvider == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(56, 189, 248, 1),
              ),
              onPressed: _pickImage,
              child: const Text(
                'Keisti nuotrauką',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Naudotojo vardas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromRGBO(56, 189, 248, 1),
              ),
              onPressed: _isSaving ? null : updateProfile,
              child: _isSaving
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text(
                      'Išsaugoti',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}