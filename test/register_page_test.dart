import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  Widget createTestApp() {
    return const MaterialApp(home: RegisterPage());
  }

  group('RegisterPage detailed', () {
    testWidgets('renders app bar with correct title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Algora'), findsOneWidget);
    });

    testWidgets('renders registration title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Registracija'), findsOneWidget);
    });

    testWidgets('renders all field labels', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Naudotojo vardas:'), findsOneWidget);
      expect(find.text('El. paštas:'), findsOneWidget);
      expect(find.text('Slaptažodis:'), findsOneWidget);
      expect(find.text('Sporto šaka:'), findsOneWidget);
    });

    testWidgets('renders three text fields', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(TextField), findsNWidgets(3));
    });

    testWidgets('renders sport dropdown', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(
        find.byType(DropdownButtonFormField<String>),
        findsOneWidget,
      );
    });

    testWidgets('password field is obscured', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final passwordField = tester.widget<TextField>(
        find.byType(TextField).at(2),
      );
      expect(passwordField.obscureText, isTrue);
    });

    testWidgets('username and email fields are not obscured', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final usernameField = tester.widget<TextField>(
        find.byType(TextField).at(0),
      );
      final emailField = tester.widget<TextField>(
        find.byType(TextField).at(1),
      );

      expect(usernameField.obscureText, isFalse);
      expect(emailField.obscureText, isFalse);
    });

    testWidgets('shows all three sports in dropdown', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final sportDropdown = find.byType(DropdownButtonFormField<String>).first;
      await tester.tap(sportDropdown);
      await tester.pumpAndSettle();

      expect(find.text('Tinklinis'), findsOneWidget);
      expect(find.text('Krepšinis'), findsOneWidget);
      expect(find.text('Futbolas'), findsOneWidget);
    });

    testWidgets('allows entering username', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField).at(0), 'Jonas');
      await tester.pump();

      expect(find.text('Jonas'), findsOneWidget);
    });

    testWidgets('allows entering email', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byType(TextField).at(1),
        'jonas@example.com',
      );
      await tester.pump();

      expect(find.text('jonas@example.com'), findsOneWidget);
    });

    testWidgets('shows snackbar when fields are empty', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      await tester.tap(find.widgetWithText(ElevatedButton, 'Registruotis'));
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Užpildykite visus laukus'), findsOneWidget);
    });

    testWidgets('shows already have account text', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Jau turite paskyrą?'), findsOneWidget);
    });

    testWidgets('shows login link', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Prisijunkite'), findsOneWidget);
    });
  });
}
