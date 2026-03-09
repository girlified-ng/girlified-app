# account_sdk.api.OrderApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**orderControllerFetchSanitaryPadOrderHistory**](OrderApi.md#ordercontrollerfetchsanitarypadorderhistory) | **GET** /v1/account/order/sanitary-pad/history | 
[**orderControllerOrderSanitaryPad**](OrderApi.md#ordercontrollerordersanitarypad) | **POST** /v1/account/order/sanitary-pad/new | 


# **orderControllerFetchSanitaryPadOrderHistory**
> OrderHistoryResponse orderControllerFetchSanitaryPadOrderHistory(page, pageSize)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getOrderApi();
final num page = 1; // num | Page
final num pageSize = 20; // num | Page size

try {
    final response = api.orderControllerFetchSanitaryPadOrderHistory(page, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderControllerFetchSanitaryPadOrderHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page | 
 **pageSize** | **num**| Page size | 

### Return type

[**OrderHistoryResponse**](OrderHistoryResponse.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **orderControllerOrderSanitaryPad**
> OrderInfo orderControllerOrderSanitaryPad(orderSanitaryPadDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getOrderApi();
final OrderSanitaryPadDTO orderSanitaryPadDTO = ; // OrderSanitaryPadDTO | 

try {
    final response = api.orderControllerOrderSanitaryPad(orderSanitaryPadDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling OrderApi->orderControllerOrderSanitaryPad: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **orderSanitaryPadDTO** | [**OrderSanitaryPadDTO**](OrderSanitaryPadDTO.md)|  | 

### Return type

[**OrderInfo**](OrderInfo.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

