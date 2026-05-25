import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/widgets/subscription_gate.dart';

import 'helpers/test_bootstrap.dart';

void main() {
  setUpAll(() async {
    await ensureTestSupabaseInitialized();
  });

  Widget createApp({Widget? fallback}) {
    return MaterialApp(
      home: Scaffold(
        body: SubscriptionGate(
          fallback: fallback,
          child: const Text('Premium turinys'),
        ),
      ),
    );
  }

  group('SubscriptionGate', () {
    testWidgets('shows fallback when user is not signed in', (tester) async {
      await tester.pumpWidget(createApp(fallback: const Text('Reikia premium')));
      await tester.pumpAndSettle();

      expect(find.text('Premium turinys'), findsNothing);
      expect(find.text('Reikia premium'), findsOneWidget);
    });

    testWidgets('renders empty fallback when user is not signed in', (
      tester,
    ) async {
      await tester.pumpWidget(createApp());
      await tester.pumpAndSettle();

      expect(find.text('Premium turinys'), findsNothing);
      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
