import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softskills_app/services/subscription_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SubscriptionService', () {
    setUp(() {
      SharedPreferences.setMockInitialValues({});
    });

    test('loads disabled subscription by default', () async {
      final service = SubscriptionService.instance;

      await service.setEnabled(false);
      await service.load();

      expect(service.isEnabled, isFalse);
    });

    test('persists enabled subscription in shared preferences', () async {
      final service = SubscriptionService.instance;

      await service.setEnabled(true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('subscription_enabled'), isTrue);

      await service.load();
      expect(service.isEnabled, isTrue);
    });

    test('notifies listeners when subscription value changes', () async {
      final service = SubscriptionService.instance;
      await service.setEnabled(false);

      var notificationCount = 0;
      void listener() => notificationCount++;
      service.addListener(listener);
      addTearDown(() => service.removeListener(listener));

      await service.setEnabled(true);
      await service.setEnabled(true);

      expect(notificationCount, 1);
    });
  });
}
