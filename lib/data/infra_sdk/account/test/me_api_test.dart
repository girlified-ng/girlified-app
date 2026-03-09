import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for MeApi
void main() {
  final instance = AccountSdk().getMeApi();

  group(MeApi, () {
    //Future accountControllerDeleteAccount(DeleteAccountDTO deleteAccountDTO) async
    test('test accountControllerDeleteAccount', () async {
      // TODO
    });

    //Future<AccountInfo> accountControllerGetDetailedAccountInfo() async
    test('test accountControllerGetDetailedAccountInfo', () async {
      // TODO
    });

    //Future accountControllerUpdateAccountPassword(UpdateAccountPasswordDTO updateAccountPasswordDTO) async
    test('test accountControllerUpdateAccountPassword', () async {
      // TODO
    });

    //Future accountControllerUpdateFcmToken(UpdateFCMTokenDTO updateFCMTokenDTO) async
    test('test accountControllerUpdateFcmToken', () async {
      // TODO
    });

    //Future<AccountInfo> accountControllerUpdateProfileImage(UpdateProfileImageDTO updateProfileImageDTO) async
    test('test accountControllerUpdateProfileImage', () async {
      // TODO
    });

  });
}
