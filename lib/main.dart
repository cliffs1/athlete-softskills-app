import 'package:flutter/material.dart';
import 'pages/MainPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();

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
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MainPage(),
    );
  }
} 


