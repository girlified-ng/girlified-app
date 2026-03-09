# account_sdk.api.MeApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountControllerDeleteAccount**](MeApi.md#accountcontrollerdeleteaccount) | **DELETE** /v1/account/me/delete | 
[**accountControllerGetDetailedAccountInfo**](MeApi.md#accountcontrollergetdetailedaccountinfo) | **GET** /v1/account/me/detailed | 
[**accountControllerUpdateAccountPassword**](MeApi.md#accountcontrollerupdateaccountpassword) | **PATCH** /v1/account/me/update-password | 
[**accountControllerUpdateFcmToken**](MeApi.md#accountcontrollerupdatefcmtoken) | **PATCH** /v1/account/me/update-fcm-token | 
[**accountControllerUpdateProfileImage**](MeApi.md#accountcontrollerupdateprofileimage) | **PATCH** /v1/account/me/update-profile-image | 


# **accountControllerDeleteAccount**
> accountControllerDeleteAccount(deleteAccountDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMeApi();
final DeleteAccountDTO deleteAccountDTO = ; // DeleteAccountDTO | 

try {
    api.accountControllerDeleteAccount(deleteAccountDTO);
} catch on DioException (e) {
    print('Exception when calling MeApi->accountControllerDeleteAccount: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **deleteAccountDTO** | [**DeleteAccountDTO**](DeleteAccountDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountControllerGetDetailedAccountInfo**
> AccountInfo accountControllerGetDetailedAccountInfo()



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMeApi();

try {
    final response = api.accountControllerGetDetailedAccountInfo();
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->accountControllerGetDetailedAccountInfo: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**AccountInfo**](AccountInfo.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountControllerUpdateAccountPassword**
> accountControllerUpdateAccountPassword(updateAccountPasswordDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMeApi();
final UpdateAccountPasswordDTO updateAccountPasswordDTO = ; // UpdateAccountPasswordDTO | 

try {
    api.accountControllerUpdateAccountPassword(updateAccountPasswordDTO);
} catch on DioException (e) {
    print('Exception when calling MeApi->accountControllerUpdateAccountPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateAccountPasswordDTO** | [**UpdateAccountPasswordDTO**](UpdateAccountPasswordDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountControllerUpdateFcmToken**
> accountControllerUpdateFcmToken(updateFCMTokenDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMeApi();
final UpdateFCMTokenDTO updateFCMTokenDTO = ; // UpdateFCMTokenDTO | 

try {
    api.accountControllerUpdateFcmToken(updateFCMTokenDTO);
} catch on DioException (e) {
    print('Exception when calling MeApi->accountControllerUpdateFcmToken: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateFCMTokenDTO** | [**UpdateFCMTokenDTO**](UpdateFCMTokenDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountControllerUpdateProfileImage**
> AccountInfo accountControllerUpdateProfileImage(updateProfileImageDTO)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getMeApi();
final UpdateProfileImageDTO updateProfileImageDTO = ; // UpdateProfileImageDTO | 

try {
    final response = api.accountControllerUpdateProfileImage(updateProfileImageDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling MeApi->accountControllerUpdateProfileImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **updateProfileImageDTO** | [**UpdateProfileImageDTO**](UpdateProfileImageDTO.md)|  | 

### Return type

[**AccountInfo**](AccountInfo.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

