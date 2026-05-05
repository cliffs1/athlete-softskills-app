import 'package:flutter/material.dart';

class CoachMessagesPage extends StatefulWidget {
  const CoachMessagesPage({super.key});

  @override
  State<CoachMessagesPage> createState() => _CoachMessagesPageState();
}

class _CoachMessagesPageState extends State<CoachMessagesPage> {
  String? selectedUser;
  final messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(167, 139, 250, 1),
        title: const Text(
          'Trenerio žinutės',
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: selectedUser,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Naudotojas',
              ),
              hint: const Text('Pasirinkite naudotoją'),
              items: const [
                DropdownMenuItem(
                  value: 'naudotojas',
                  child: Text('Naudotojas'),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedUser = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: messageController,
              minLines: 5,
              maxLines: 8,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                border: OutlineInputBorder(),
                labelText: 'Žinutė',
                hintText: 'Įveskite žinutę',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
