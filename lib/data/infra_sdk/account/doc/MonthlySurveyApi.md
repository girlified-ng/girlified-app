# account_sdk.api.MonthlySurveyApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountControllerFetchMonthlySurveyHistory**](MonthlySurveyApi.md#accountcontrollerfetchmonthlysurveyhistory) | **GET** /v1/account/me/history | 
[**accountControllerRegisterMonthlySurvey**](MonthlySurveyApi.md#accountcontrollerregistermonthlysurvey) | **POST** /v1/account/me/new | 


# **accountControllerFetchMonthlySurveyHistory**
> MonthlySurveyHistoryResponse accountControllerFetchMonthlySurveyHistory(page, pageSize)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMonthlySurveyApi();
final num page = 1; // num | Page
final num pageSize = 20; // num | Page size

try {
    final response = api.accountControllerFetchMonthlySurveyHistory(page, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MonthlySurveyApi->accountControllerFetchMonthlySurveyHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**| Page | 
 **pageSize** | **num**| Page size | 

### Return type

[**MonthlySurveyHistoryResponse**](MonthlySurveyHistoryResponse.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountControllerRegisterMonthlySurvey**
> MonthlySurveyInfo accountControllerRegisterMonthlySurvey(registerMonthlySurveyDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMonthlySurveyApi();
final RegisterMonthlySurveyDTO registerMonthlySurveyDTO = ; // RegisterMonthlySurveyDTO | 

try {
    final response = api.accountControllerRegisterMonthlySurvey(registerMonthlySurveyDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MonthlySurveyApi->accountControllerRegisterMonthlySurvey: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registerMonthlySurveyDTO** | [**RegisterMonthlySurveyDTO**](RegisterMonthlySurveyDTO.md)|  | 

### Return type

[**MonthlySurveyInfo**](MonthlySurveyInfo.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

