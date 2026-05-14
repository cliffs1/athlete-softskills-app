import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:softskills_app/pages/ProfilePage.dart';

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
    return const MaterialApp(home: ProfilePage());
  }

  group('ProfilePage', () {
    testWidgets('shows loading indicator initially', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders app bar with correct title', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Profilis'), findsOneWidget);
    });

    testWidgets('shows email label', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('el. paštas'), findsOneWidget);
    });

    testWidgets('shows password label', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.textContaining('slaptažodis'), findsOneWidget);
    });

    testWidgets('shows change password button', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Keisti slaptažodį'), findsOneWidget);
    });

    testWidgets('shows delete account button', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Ištrinti paskyrą'), findsOneWidget);
    });

    testWidgets('shows settings icon button', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.settings), findsOneWidget);
    });

    testWidgets('shows person icon when no profile picture', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('shows CircleAvatar', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('has two elevated buttons', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      expect(find.byType(ElevatedButton), findsNWidgets(2));
    });

    testWidgets('change password button is tappable', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Keisti slaptažodį'),
      );
      expect(button.onPressed, isNotNull);
    });

    testWidgets('delete account button is tappable', (tester) async {
      await setTestScreenSize(tester);
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      final button = tester.widget<ElevatedButton>(
        find.widgetWithText(ElevatedButton, 'Ištrinti paskyrą'),
      );
      expect(button.onPressed, isNotNull);
    });
  });
}