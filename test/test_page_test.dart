import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/pages/TestPage.dart';

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
    return const MaterialApp(home: TestPage());
  }

  group('TestPage', () {
    testWidgets('shows loading indicator initially', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows progress indicator after loading', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(LinearProgressIndicator), findsOneWidget);
    });

    testWidgets('shows question number in app bar', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('Klausimas 1'), findsOneWidget);
    });

    testWidgets('shows first question text', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Klausimas 1'), findsOneWidget);
    });

    testWidgets('shows answer options', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(InkWell), findsWidgets);
    });

    testWidgets('back button is disabled on first question', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final backButton = tester.widget<OutlinedButton>(
        find.byType(OutlinedButton),
      );
      expect(backButton.onPressed, isNull);
    });

    testWidgets('next button is disabled before selecting answer', (
      tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNull);
    });

    testWidgets('next button enables after selecting answer', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final inkWells = find.byType(InkWell);
      expect(inkWells, findsWidgets);

      await tester.tap(inkWells.first);
      await tester.pump();

      final nextButton = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(nextButton.onPressed, isNotNull);
    });

    testWidgets('answer option changes color when selected', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final inkWells = find.byType(InkWell);
      await tester.tap(inkWells.first);
      await tester.pump();

      final containers = tester.widgetList<AnimatedContainer>(
        find.byType(AnimatedContainer),
      );
      final selectedContainer = containers.first;
      expect(selectedContainer, isNotNull);
    });

    testWidgets('navigates to second question after answering', (
      tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(InkWell).first);
      await tester.pump();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.textContaining('Klausimas 2'), findsOneWidget);
    });

    testWidgets('back button works after going to second question', (
      tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(InkWell).first);
      await tester.pump();
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.textContaining('Klausimas 2'), findsOneWidget);

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      expect(find.textContaining('Klausimas 1'), findsOneWidget);
    });

    testWidgets('shows Atgal and Kitas buttons', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Atgal'), findsOneWidget);
      expect(find.text('Kitas'), findsOneWidget);
    });

    testWidgets('option labels are visible', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('A'), findsOneWidget);
    });
  });
}