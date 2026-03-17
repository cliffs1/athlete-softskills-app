import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register() {
    String username = usernameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Užpildykite visus laukus")),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registracija sėkminga")),
    );
  }

  void goToLogin() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(229, 231, 235, 1),
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
        child: SingleChildScrollView(
          child: Container(
            width: 320,
            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const Center(
                  child: Text(
                    "Registracija",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(11, 18, 32, 1)
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                const Text("Naudotojo vardas:", style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(11, 18, 32, 1)
                  )
                ),
                const SizedBox(height: 6),

                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Įveskite naudotojo vardą",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                const Text("El. paštas:", style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(11, 18, 32, 1)
                  )
                ),
                const SizedBox(height: 6),

                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Įveskite el. paštą",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 16),

                const Text("Slaptažodis:", style: TextStyle(
                    fontSize: 18, color: Color.fromRGBO(11, 18, 32, 1)
                  )
                ),
                const SizedBox(height: 6),

                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Įveskite slaptažodį",
                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 24),

                Center(
                  child: ElevatedButton(
                    onPressed: register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(56, 189, 248, 1),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      "Registruotis",
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Center(
                  child: Column(
                    children: [
                      const Text("Jau turite paskyrą?"),
                      TextButton(
                        onPressed: goToLogin,
                        child: const Text("Prisijunkite"),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}