import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/pages/TipsPage.dart';

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
    return const MaterialApp(home: TipsPage());
  }

  group('TipsPage', () {
    testWidgets('renders app bar with correct title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Patarimai'), findsWidgets);
    });

    testWidgets('shows Patarimai section title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Patarimai'), findsWidgets);
    });

    testWidgets('shows Straipsniai section title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Straipsniai'), findsOneWidget);
    });

    testWidgets('shows Bendravimas tip card', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Bendravimas'), findsOneWidget);
    });

    testWidgets('shows Susikaupimas tip card', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Susikaupimas'), findsOneWidget);
    });

    testWidgets('shows Pasitikėjimas tip card', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Pasitikėjimas'), findsOneWidget);
    });

    testWidgets('shows tip card descriptions', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(
        find.text(
          'Stenkitės aktyviai klausytis ir priimti kritiką iš komandos narių.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'Rungtynių metu svarbu nepasimesti tarp garso ir trikdžių.',
        ),
        findsOneWidget,
      );
      expect(
        find.text(
          'Svarbu neprarasti pasitikėjimo, nors ir nesiseka momente.',
        ),
        findsOneWidget,
      );
    });

    testWidgets('shows lightbulb icons for tip cards', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.lightbulb), findsNWidgets(3));
    });

    testWidgets('shows article icons', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.article_outlined), findsWidgets);
    });

    testWidgets('shows open in new icons for articles', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.open_in_new), findsWidgets);
    });

    testWidgets('shows article cards as tappable', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('page is scrollable', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('article cards show URLs', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('http'), findsWidgets);
    });
  });
}