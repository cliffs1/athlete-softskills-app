import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubscriptionGate extends StatefulWidget {
  const SubscriptionGate({
    super.key,
    required this.child,
    this.fallback,
  });

  final Widget child;
  final Widget? fallback;

  @override
  State<SubscriptionGate> createState() => _SubscriptionGateState();
}

class _SubscriptionGateState extends State<SubscriptionGate> {
  final supabase = Supabase.instance.client;

  bool loading = true;
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    checkSubscription();
  }

  Future<void> checkSubscription() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        setState(() {
          loading = false;
          isPremium = false;
        });
        return;
      }

      final data = await supabase
          .from('naudotojas')
          .select('subscription_type')
          .eq('auth_user_id', user.id)
          .single();

      setState(() {
        isPremium = data['subscription_type'] == 'premium';
        loading = false;
      });
    } catch (e) {
      debugPrint('Subscription check error: $e');

      setState(() {
        loading = false;
        isPremium = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const SizedBox.shrink();
    }

    if (isPremium) {
      return widget.child;
    }

    return widget.fallback ?? const SizedBox.shrink();
  }
}