import 'package:test/test.dart';
import 'package:auth_sdk/auth_sdk.dart';


/// tests for NotificationsApi
void main() {
  final instance = AuthSdk().getNotificationsApi();

  group(NotificationsApi, () {
    //Future authHelperControllerSendTestNotification(String fcmToken) async
    test('test authHelperControllerSendTestNotification', () async {
      // TODO
    });

  });
}
