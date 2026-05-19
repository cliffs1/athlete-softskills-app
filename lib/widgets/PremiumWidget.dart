import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PremiumWidget extends StatelessWidget {
  const PremiumWidget({super.key, required this.onPremiumActivated,});

  final Future<void> Function() onPremiumActivated;

  Future<void> _activatePremium(BuildContext context) async {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user == null) return;

    try {
      await supabase
          .from('naudotojas')
          .update({'subscription_type': 'premium'})
          .eq('auth_user_id', user.id);

      await onPremiumActivated();

      if (!context.mounted) return;

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Premium sėkmingai aktyvuotas!'),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Klaida aktyvuojant premium: $e'),
        ),
      );
    }
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Premium narystė'),
        content: const Text(
          'Ar norite aktyvuoti Premium narystę?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Atšaukti'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
            ),
            onPressed: () => _activatePremium(context),
            child: const Text('Gauti Premium'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFD700), Color(0xFFFFA500)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Tapk Premium nariu!",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            "Atrakink išplėstinę statistiką ir dar daugiau!",
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.amber,
            ),
            onPressed: () => _showPremiumDialog(context),
            child: const Text("Gauti premium"),
          )
        ],
      ),
    );
  }
}