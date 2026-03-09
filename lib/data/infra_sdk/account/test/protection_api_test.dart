import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for ProtectionApi
void main() {
  final instance = AccountSdk().getProtectionApi();

  group(ProtectionApi, () {
    //Future<AccountInfo> accountControllerUpdateSocialHandles(UpdateSocialHandlesDTO updateSocialHandlesDTO) async
    test('test accountControllerUpdateSocialHandles', () async {
      // TODO
    });

  });
}
