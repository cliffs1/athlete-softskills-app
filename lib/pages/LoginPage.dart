import 'package:flutter/material.dart';
import 'RegisterPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'MainPage.dart';
import 'WelcomePage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final supabase = Supabase.instance.client;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Užpildykite visus laukus")),
      );
      return;
    }

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final user = response.user;

      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Neteisingi prisijungimo duomenys")),
        );
        return;
      }

      final data = await supabase
          .from('naudotojas')
          .select('hide_welcome')
          .eq('auth_user_id', user.id)
          .single();

      final hideWelcome = data['hide_welcome'] ?? true;
      print(hideWelcome);

      if (!mounted) return;

      if (hideWelcome) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainPage()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WelcomePage()),
        );
      }

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

void goToRegister() {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RegisterPage(),
    ),
  );
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
              'assets/brain_logo_goodremakecolor.png',
              height: 60,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black, width: 2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Prisijungti',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(11, 18, 32, 1)
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'El. paštas:',
                    style: TextStyle(fontSize: 18, color: Color.fromRGBO(11, 18, 32, 1)),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Įveskite el. paštą',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    'Slaptažodis:',
                    style: TextStyle(fontSize: 18, color: Color.fromRGBO(11, 18, 32, 1)),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Įveskite slaptažodį',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Center(
                    child: ElevatedButton(
                      onPressed: login,
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
                        'Prisijungti',
                        style: TextStyle(fontSize: 18, color: Color.fromRGBO(255, 255, 255, 1)),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'Dar neturite paskyros?',
                          style: TextStyle(fontSize: 16),
                        ),
                        TextButton(
                          onPressed: goToRegister,
                          child: const Text(
                            'Prisiregistruokite',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}