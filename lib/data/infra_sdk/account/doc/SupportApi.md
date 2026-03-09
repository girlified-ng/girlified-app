# account_sdk.api.SupportApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**supportControllerContactUs**](SupportApi.md#supportcontrollercontactus) | **POST** /v1/account/support/contact-us | 


# **supportControllerContactUs**
> supportControllerContactUs(contactUsDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getSupportApi();
final ContactUsDTO contactUsDTO = ; // ContactUsDTO | 

try {
    api.supportControllerContactUs(contactUsDTO);
} catch on DioException (e) {
    print('Exception when calling SupportApi->supportControllerContactUs: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **contactUsDTO** | [**ContactUsDTO**](ContactUsDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

