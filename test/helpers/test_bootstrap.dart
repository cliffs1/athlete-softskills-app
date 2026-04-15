import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> ensureTestSupabaseInitialized() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  try {
    Supabase.instance.client;
    return;
  } catch (_) {
    await Supabase.initialize(
      url: 'https://ewsjzgdnxuqtjroehtgy.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImV3c2p6Z2RueHVxdGpyb2VodGd5Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI3MzcxNTMsImV4cCI6MjA4ODMxMzE1M30.Vt6ibckFc6vTeB05LKByOyohqpyOGnxlzL0BumDwHIQ',
    );
  }
}
