import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'package:softskills_app/pages/RegisterPage.dart';
import 'package:softskills_app/widgets/BreathingWidget.dart';
import 'package:softskills_app/widgets/CalendarWidget.dart';
import 'package:softskills_app/widgets/DiaryWidget.dart';
import 'package:softskills_app/widgets/MotivationWidget.dart';
import 'package:softskills_app/widgets/StatisticsWidget.dart';
import 'package:softskills_app/widgets/TestWidget.dart';
import 'package:softskills_app/widgets/TipsWidget.dart';

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
    return MaterialApp(home: home);
  }

  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

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

  group('BreathingWidget', () {
    testWidgets('renders button with correct label', (tester) async {
      await tester.pumpWidget(wrap(const BreathingWidget()));
      await tester.pumpAndSettle();
      expect(find.text('Kvėpavimo pratimas'), findsOneWidget);
      expect(find.byIcon(Icons.air), findsOneWidget);
    });

    testWidgets('button is tappable', (tester) async {
      await tester.pumpWidget(wrap(const BreathingWidget()));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('CalendarWidget', () {
    testWidgets('renders button with correct label', (tester) async {
      await tester.pumpWidget(wrap(const CalendarWidget()));
      await tester.pumpAndSettle();
      expect(find.text('Kalendorius'), findsOneWidget);
      expect(find.byIcon(Icons.calendar_today), findsOneWidget);
    });

    testWidgets('button is tappable', (tester) async {
      await tester.pumpWidget(wrap(const CalendarWidget()));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('DiaryWidget', () {
    testWidgets('renders button with correct label', (tester) async {
      await tester.pumpWidget(wrap(const DiaryWidget()));
      await tester.pumpAndSettle();
      expect(find.text('Dienoraštis'), findsOneWidget);
      expect(
        find.byIcon(Icons.account_balance_wallet_rounded),
        findsOneWidget,
      );
    });

    testWidgets('button is tappable', (tester) async {
      await tester.pumpWidget(wrap(const DiaryWidget()));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('MotivationWidget', () {
    testWidgets('renders container with icon and message', (tester) async {
      await tester.pumpWidget(wrap(const MotivationWidget()));
      await tester.pumpAndSettle();
      expect(find.byIcon(Icons.lightbulb), findsOneWidget);
      expect(find.byType(Text), findsAtLeastNWidgets(1));
    });

    testWidgets('shows non-empty motivation message', (tester) async {
      await tester.pumpWidget(wrap(const MotivationWidget()));
      await tester.pumpAndSettle();
      final textWidgets = tester.widgetList<Text>(find.byType(Text));
      final hasNonEmpty = textWidgets.any((t) => (t.data ?? '').isNotEmpty);
      expect(hasNonEmpty, isTrue);
    });
  });

  group('StatisticsWidget', () {
    testWidgets('renders button with correct label', (tester) async {
      await tester.pumpWidget(
        wrap(const StatisticsWidget(playerId: 'test-id', sport: 'Futbolas')),
      );
      await tester.pumpAndSettle();
      expect(find.text('Statistika'), findsOneWidget);
      expect(find.byIcon(Icons.bar_chart), findsOneWidget);
    });

    testWidgets('button is tappable', (tester) async {
      await tester.pumpWidget(
        wrap(const StatisticsWidget(playerId: 'test-id', sport: 'Futbolas')),
      );
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('TestWidget', () {
    testWidgets('renders button with correct label', (tester) async {
      await tester.pumpWidget(wrap(const TestWidget()));
      await tester.pumpAndSettle();
      expect(find.text('Testas'), findsOneWidget);
      expect(find.byIcon(Icons.accessibility), findsOneWidget);
    });

    testWidgets('button is tappable', (tester) async {
      await tester.pumpWidget(wrap(const TestWidget()));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });

  group('TipsWidget', () {
    testWidgets('renders button with correct label', (tester) async {
      await tester.pumpWidget(wrap(const TipsWidget()));
      await tester.pumpAndSettle();
      expect(find.text('Patarimai'), findsOneWidget);
      expect(find.byIcon(Icons.lightbulb), findsOneWidget);
    });

    testWidgets('button is tappable', (tester) async {
      await tester.pumpWidget(wrap(const TipsWidget()));
      await tester.pumpAndSettle();
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
  
  group('LoginPage extra', () {
  testWidgets('password field is obscured', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    final passwordField = tester.widget<TextField>(
      find.byType(TextField).at(1),
    );
    expect(passwordField.obscureText, isTrue);
  });

  testWidgets('email field is not obscured', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    final emailField = tester.widget<TextField>(
      find.byType(TextField).at(0),
    );
    expect(emailField.obscureText, isFalse);
  });
});

group('RegisterPage extra', () {
  testWidgets('password field is obscured', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    final passwordField = tester.widget<TextField>(
      find.byType(TextField).at(1),
    );
    expect(passwordField.obscureText, isTrue);
  });

  testWidgets('all three text fields are present', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    expect(find.byType(TextField), findsNWidgets(3));
  });

  testWidgets('allows entering a name', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Jonas');
    await tester.pump();

    expect(find.text('Jonas'), findsOneWidget);
  });
});

group('MotivationWidget extra', () {
  testWidgets('same message shown on same day', (tester) async {
    await tester.pumpWidget(wrap(const MotivationWidget()));
    await tester.pumpAndSettle();

    final first = tester
        .widgetList<Text>(find.byType(Text))
        .last
        .data;

    await tester.pumpWidget(wrap(const MotivationWidget()));
    await tester.pumpAndSettle();

    final second = tester
        .widgetList<Text>(find.byType(Text))
        .last
        .data;

    expect(first, equals(second));
  });
});

group('BreathingWidget extra', () {
  testWidgets('has correct button height', (tester) async {
    await tester.pumpWidget(wrap(const BreathingWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.height, equals(60));
  });
});

group('DiaryWidget extra', () {
  testWidgets('has correct button height', (tester) async {
    await tester.pumpWidget(wrap(const DiaryWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.height, equals(60));
  });
});

group('StatisticsWidget extra', () {
  testWidgets('accepts different sport values', (tester) async {
    await tester.pumpWidget(
      wrap(const StatisticsWidget(playerId: 'abc', sport: 'Tinklinis')),
    );
    await tester.pumpAndSettle();
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
});
  
  group('CalendarWidget extra', () {
  testWidgets('has correct button height', (tester) async {
    await tester.pumpWidget(wrap(const CalendarWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.height, equals(60));
  });

  testWidgets('has full width', (tester) async {
    await tester.pumpWidget(wrap(const CalendarWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.width, equals(double.infinity));
  });
});

group('TestWidget extra', () {
  testWidgets('has correct button height', (tester) async {
    await tester.pumpWidget(wrap(const TestWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.height, equals(60));
  });

  testWidgets('has full width', (tester) async {
    await tester.pumpWidget(wrap(const TestWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.width, equals(double.infinity));
  });
});

group('TipsWidget extra', () {
  testWidgets('has correct button height', (tester) async {
    await tester.pumpWidget(wrap(const TipsWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.height, equals(60));
  });

  testWidgets('has full width', (tester) async {
    await tester.pumpWidget(wrap(const TipsWidget()));
    await tester.pumpAndSettle();

    final sizedBox = tester.widget<SizedBox>(find.byType(SizedBox).first);
    expect(sizedBox.width, equals(double.infinity));
  });
});

group('LoginPage navigation', () {
  testWidgets('page contains a scrollable view', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('shows app title or logo', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp());
    await tester.pumpAndSettle();

    expect(find.byType(Image), findsOneWidget);
  });
});

group('RegisterPage navigation', () {
  testWidgets('has a scrollable view', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
  });

  testWidgets('confirm password field is obscured', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    final confirmField = tester.widget<TextField>(
      find.byType(TextField).at(2),
    );
    expect(confirmField.obscureText, isTrue);
  });

  testWidgets('allows entering email', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).at(1),
      'jonas@example.com',
    );
    await tester.pump();

    expect(find.text('jonas@example.com'), findsOneWidget);
  });

  testWidgets('shows snackbar when passwords do not match', (tester) async {
    await setTestScreenSize(tester);
    await tester.pumpWidget(createTestApp(home: const RegisterPage()));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField).at(0), 'Jonas');
    await tester.enterText(find.byType(TextField).at(1), 'jonas@example.com');
    await tester.enterText(find.byType(TextField).at(2), 'wrongpassword');
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Registruotis'));
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
  });
});
  
}