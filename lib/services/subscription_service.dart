import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubscriptionService extends ChangeNotifier {
  SubscriptionService._();

  static final SubscriptionService instance = SubscriptionService._();
  static const String _storageKey = 'subscription_enabled';

  bool _isEnabled = false;

  bool get isEnabled => _isEnabled;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_storageKey) ?? false;
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    if (_isEnabled == value) return;

    _isEnabled = value;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_storageKey, value);
  }
}
