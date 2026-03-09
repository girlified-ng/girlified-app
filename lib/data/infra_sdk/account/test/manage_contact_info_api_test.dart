import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for ManageContactInfoApi
void main() {
  final instance = AccountSdk().getManageContactInfoApi();

  group(ManageContactInfoApi, () {
    //Future accountControllerUpdateAccountEmail(UpdateAccountEmailDTO updateAccountEmailDTO) async
    test('test accountControllerUpdateAccountEmail', () async {
      // TODO
    });

    //Future<AccountInfo> accountControllerUpdateAccountLocation(UpdateAccountLocationDTO updateAccountLocationDTO) async
    test('test accountControllerUpdateAccountLocation', () async {
      // TODO
    });

    //Future<AccountInfo> accountControllerUpdateAccountName(UpdateAccountNameDTO updateAccountNameDTO) async
    test('test accountControllerUpdateAccountName', () async {
      // TODO
    });

    //Future<AccountInfo> accountControllerUpdateAccountPhone(UpdateAccountPhoneDTO updateAccountPhoneDTO) async
    test('test accountControllerUpdateAccountPhone', () async {
      // TODO
    });

    //Future<AccountInfo> accountControllerVerifyNewAccountEmail(VerifyNewAccountEmailDTO verifyNewAccountEmailDTO) async
    test('test accountControllerVerifyNewAccountEmail', () async {
      // TODO
    });

  });
}
