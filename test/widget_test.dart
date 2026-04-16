import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/pages/RegisterPage.dart';

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

  Widget createTestApp({Widget home = const LoginPage()}) {
    return MaterialApp(
      home: home,
    );
  }

  group('LoginPage', () {
    testWidgets('renders expected fields and actions', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Prisijungti'), findsNWidgets(2));
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Prisiregistruokite'), findsOneWidget);
    });

    testWidgets('shows validation snackbar for empty login', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Prisijungti'));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('allows entering email and password', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).at(0),
        'athlete@example.com',
      );
      await tester.enterText(find.byType(TextField).at(1), 'secret123');
      await tester.pump();

      expect(find.text('athlete@example.com'), findsOneWidget);
      expect(find.text('secret123'), findsOneWidget);
    });

    testWidgets('register button opens registration page', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Prisiregistruokite'));
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
      expect(find.text('Registracija'), findsOneWidget);
    });
  });

  group('RegisterPage', () {
    testWidgets('renders registration form fields', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp(home: const RegisterPage()));
      await tester.pumpAndSettle();

      expect(find.text('Registracija'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(3));
      expect(find.byType(DropdownButtonFormField<String>), findsOneWidget);
      expect(
        find.widgetWithText(ElevatedButton, 'Registruotis'),
        findsOneWidget,
      );
    });

    testWidgets('shows validation snackbar for empty registration', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp(home: const RegisterPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Registruotis'));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
    });

    testWidgets('shows available sports in dropdown', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp(home: const RegisterPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();

      expect(find.text('Tinklinis'), findsWidgets);
      expect(find.textContaining('Krep'), findsWidgets);
      expect(find.text('Futbolas'), findsWidgets);
    });

    testWidgets('allows selecting a sport from dropdown', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp(home: const RegisterPage()));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_drop_down).first);
      await tester.pumpAndSettle();
      await tester.tap(find.text('Futbolas').first);
      await tester.pumpAndSettle();

      expect(find.text('Futbolas'), findsWidgets);
    });

    testWidgets('login link pops back to previous page', (
      WidgetTester tester,
    ) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Prisiregistruokite'));
      await tester.pumpAndSettle();
      expect(find.byType(RegisterPage), findsOneWidget);

      await tester.tap(find.text('Prisijunkite'));
      await tester.pumpAndSettle();

      expect(find.byType(LoginPage), findsOneWidget);
      expect(find.byType(RegisterPage), findsNothing);
    });
  });
}
