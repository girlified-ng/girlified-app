import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for MonthlySurveyApi
void main() {
  final instance = AccountSdk().getMonthlySurveyApi();

  group(MonthlySurveyApi, () {
    //Future<MonthlySurveyHistoryResponse> accountControllerFetchMonthlySurveyHistory(num page, num pageSize) async
    test('test accountControllerFetchMonthlySurveyHistory', () async {
      // TODO
    });

    //Future<MonthlySurveyInfo> accountControllerRegisterMonthlySurvey(RegisterMonthlySurveyDTO registerMonthlySurveyDTO) async
    test('test accountControllerRegisterMonthlySurvey', () async {
      // TODO
    });

  });
}
