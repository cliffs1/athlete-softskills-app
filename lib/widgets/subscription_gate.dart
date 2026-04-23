import 'package:flutter/material.dart';
import 'package:softskills_app/services/subscription_service.dart';

class SubscriptionGate extends StatelessWidget {
  const SubscriptionGate({
    super.key,
    required this.child,
    this.fallback,
  });

  final Widget child;
  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: SubscriptionService.instance,
      builder: (context, _) {
        if (SubscriptionService.instance.isEnabled) {
          return child;
        }

        return fallback ?? const SizedBox.shrink();
      },
    );
  }
}
