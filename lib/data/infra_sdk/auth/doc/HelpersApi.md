# auth_sdk.api.HelpersApi

## Load the API package
```dart
import 'package:auth_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authHelperControllerCheckEmailAvailability**](HelpersApi.md#authhelpercontrollercheckemailavailability) | **GET** /v1/auth/helper/availability/email | 


# **authHelperControllerCheckEmailAvailability**
> AvailabilityCheckInfo authHelperControllerCheckEmailAvailability(email)



### Example
```dart
import 'package:auth_sdk/api.dart';

final api = AuthSdk().getHelpersApi();
final String email = devoncarter@icloud.com; // String | 

try {
    final response = api.authHelperControllerCheckEmailAvailability(email);
    print(response);
} catch on DioException (e) {
    print('Exception when calling HelpersApi->authHelperControllerCheckEmailAvailability: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **email** | **String**|  | 

### Return type

[**AvailabilityCheckInfo**](AvailabilityCheckInfo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

