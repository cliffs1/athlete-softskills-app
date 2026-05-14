import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/pages/WelcomePage.dart';

import 'helpers/test_bootstrap.dart';

void main() {
  setUpAll(() async {
    await ensureTestSupabaseInitialized();
  });

  Future<void> setTestScreenSize(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 1200));
    addTearDown(() async {
      await tester.binding.setSurfaceSize(null);
    });
  }

  Widget createTestApp() {
    return const MaterialApp(home: WelcomePage());
  }

  group('WelcomePage', () {
    testWidgets('renders app bar with correct title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Algora'), findsWidgets);
    });

    testWidgets('shows welcome message with fallback name', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('Sveiki'), findsOneWidget);
    });

    testWidgets('shows app description text', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(
        find.textContaining('minkštuosius įgūdžius'),
        findsOneWidget,
      );
    });

    testWidgets('shows bullet points', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('Atlik testus'), findsOneWidget);
      expect(find.textContaining('Sek progresą'), findsOneWidget);
      expect(find.textContaining('Stebėk savo augimą'), findsOneWidget);
    });

    testWidgets('shows Tęsti button', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Tęsti'), findsOneWidget);
    });

    testWidgets('Tęsti button is tappable', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Tęsti'),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('shows Nerodyti daugiau checkbox', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Nerodyti daugiau'), findsOneWidget);
      expect(find.byType(Checkbox), findsOneWidget);
    });

    testWidgets('checkbox is unchecked by default', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('checkbox can be checked', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isTrue);
    });

    testWidgets('checkbox can be unchecked after checking', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(Checkbox));
      await tester.pump();
      await tester.tap(find.byType(Checkbox));
      await tester.pump();

      final checkbox = tester.widget<Checkbox>(find.byType(Checkbox));
      expect(checkbox.value, isFalse);
    });

    testWidgets('shows logo image', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(Image), findsWidgets);
    });

    testWidgets('page is scrollable', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('shows white info container', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsWidgets);
    });
  });
}