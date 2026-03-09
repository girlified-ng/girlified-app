import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for OrderApi
void main() {
  final instance = AccountSdk().getOrderApi();

  group(OrderApi, () {
    //Future<OrderHistoryResponse> orderControllerFetchSanitaryPadOrderHistory(num page, num pageSize) async
    test('test orderControllerFetchSanitaryPadOrderHistory', () async {
      // TODO
    });

    //Future<OrderInfo> orderControllerOrderSanitaryPad(OrderSanitaryPadDTO orderSanitaryPadDTO) async
    test('test orderControllerOrderSanitaryPad', () async {
      // TODO
    });

  });
}
