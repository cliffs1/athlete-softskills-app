import 'package:flutter/material.dart';
import 'package:softskills_app/pages/LoginPage.dart';
import 'pages/MainPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

final RouteObserver<ModalRoute<void>> routeObserver =
RouteObserver<ModalRoute<void>>();

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await initializeDateFormatting('lt_LT', null);

  await Supabase.initialize(
    url: 'https://ewsjzgdnxuqtjroehtgy.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV3c2p6Z2RueHVxdGpyb2VodGd5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI3MzcxNTMsImV4cCI6MjA4ODMxMzE1M30.Vt6ibckFc6vTeB05LKByOyohqpyOGnxlzL0BumDwHIQ',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [routeObserver],
      title: 'Flutter Demo',
      locale: const Locale('lt', 'LT'),

      supportedLocales: const [
        Locale('lt', 'LT'),
        Locale('en', 'US'),
      ],

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
} 


