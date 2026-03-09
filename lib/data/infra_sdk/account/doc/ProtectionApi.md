# account_sdk.api.ProtectionApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountControllerUpdateSocialHandles**](ProtectionApi.md#accountcontrollerupdatesocialhandles) | **PATCH** /v1/account/me/update-social-handles | 


# **accountControllerUpdateSocialHandles**
> AccountInfo accountControllerUpdateSocialHandles(updateSocialHandlesDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getProtectionApi();
final UpdateSocialHandlesDTO updateSocialHandlesDTO = ; // UpdateSocialHandlesDTO | 

try {
    final response = api.accountControllerUpdateSocialHandles(updateSocialHandlesDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling ProtectionApi->accountControllerUpdateSocialHandles: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateSocialHandlesDTO** | [**UpdateSocialHandlesDTO**](UpdateSocialHandlesDTO.md)|  | 

### Return type

[**AccountInfo**](AccountInfo.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

