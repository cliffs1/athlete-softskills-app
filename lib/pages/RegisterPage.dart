import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final supabase = Supabase.instance.client;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? selectedSport;

  final List<String> sports = [
    "Tinklinis",
    "Krepšinis",
    "Futbolas"
  ];

  int getSportId(String sport) {
    switch (sport) {
      case "Tinklinis":
        return 4;
      case "Krepšinis":
        return 1;
      case "Futbolas":
        return 2;
      default:
        return 0;
    }
  }

 Future<void> register() async {
  String username = usernameController.text.trim();
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (username.isEmpty || email.isEmpty || password.isEmpty || selectedSport == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Užpildykite visus laukus")),
    );
    return;
  }

  try {
    final AuthResponse response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;

    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nepavyko sukurti vartotojo")),
      );
      return;
    }

    await supabase.from('naudotojas').insert({
      'auth_user_id': user.id,
      'vardas': username,
      'el_pastas': email,
      'fk_sporto_saka': getSportId(selectedSport!),
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Registracija sėkminga")),
    );

    Navigator.pop(context);
  } on AuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Auth klaida: ${e.message}")),
    );
  } on PostgrestException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("DB klaida: ${e.message}")),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Klaida: $e")),
    );
  }
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
              'assets/brain_logo_goodremakecolor.png',
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

                const SizedBox(height: 16),

                const Text("Sporto šaka:", style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(11, 18, 32, 1),
                )),

                const SizedBox(height: 6),

                DropdownButtonFormField<String>(
                  initialValue: selectedSport,
                  items: sports.map((sport) {
                    return DropdownMenuItem(
                      value: sport,
                      child: Text(sport),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSport = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Pasirinkite sportą",
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