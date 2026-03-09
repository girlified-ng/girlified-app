import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for SupportApi
void main() {
  final instance = AccountSdk().getSupportApi();

  group(SupportApi, () {
    //Future supportControllerContactUs(ContactUsDTO contactUsDTO) async
    test('test supportControllerContactUs', () async {
      // TODO
    });

  });
}
