import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for NotificationsApi
void main() {
  final instance = AccountSdk().getNotificationsApi();

  group(NotificationsApi, () {
    //Future<NotificationsResponse> accountNotificationControllerGetNotifications({ num page, num pageSize }) async
    test('test accountNotificationControllerGetNotifications', () async {
      // TODO
    });

    //Future<NotificationInfo> accountNotificationControllerReadNotification({ num notificationId }) async
    test('test accountNotificationControllerReadNotification', () async {
      // TODO
    });

  });
}
