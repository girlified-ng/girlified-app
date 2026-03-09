import 'package:test/test.dart';
import 'package:auth_sdk/auth_sdk.dart';


/// tests for HelpersApi
void main() {
  final instance = AuthSdk().getHelpersApi();

  group(HelpersApi, () {
    //Future<AvailabilityCheckInfo> authHelperControllerCheckEmailAvailability(String email) async
    test('test authHelperControllerCheckEmailAvailability', () async {
      // TODO
    });

  });
}
