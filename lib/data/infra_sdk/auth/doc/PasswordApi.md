# auth_sdk.api.PasswordApi

## Load the API package
```dart
import 'package:auth_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authControllerForgotPassword**](PasswordApi.md#authcontrollerforgotpassword) | **POST** /v1/auth/forgot-password | 
[**authControllerResetPassword**](PasswordApi.md#authcontrollerresetpassword) | **POST** /v1/auth/reset-password | 
[**authControllerResetPasswordOtpVerification**](PasswordApi.md#authcontrollerresetpasswordotpverification) | **POST** /v1/auth/reset-password-otp-verification | 


# **authControllerForgotPassword**
> authControllerForgotPassword(forgotPasswordDTO)



### Example
```dart
import 'package:auth_sdk/api.dart';

final api = AuthSdk().getPasswordApi();
final ForgotPasswordDTO forgotPasswordDTO = ; // ForgotPasswordDTO | 

try {
    api.authControllerForgotPassword(forgotPasswordDTO);
} catch on DioException (e) {
    print('Exception when calling PasswordApi->authControllerForgotPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **forgotPasswordDTO** | [**ForgotPasswordDTO**](ForgotPasswordDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerResetPassword**
> authControllerResetPassword(resetPasswordDTO)



### Example
```dart
import 'package:auth_sdk/api.dart';

final api = AuthSdk().getPasswordApi();
final ResetPasswordDTO resetPasswordDTO = ; // ResetPasswordDTO | 

try {
    api.authControllerResetPassword(resetPasswordDTO);
} catch on DioException (e) {
    print('Exception when calling PasswordApi->authControllerResetPassword: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordDTO** | [**ResetPasswordDTO**](ResetPasswordDTO.md)|  | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authControllerResetPasswordOtpVerification**
> ResetPasswordOTPVerificationResponsePayload authControllerResetPasswordOtpVerification(resetPasswordVerificationDTO)



### Example
```dart
import 'package:auth_sdk/api.dart';

final api = AuthSdk().getPasswordApi();
final ResetPasswordVerificationDTO resetPasswordVerificationDTO = ; // ResetPasswordVerificationDTO | 

try {
    final response = api.authControllerResetPasswordOtpVerification(resetPasswordVerificationDTO);
    print(response);
} catch on DioException (e) {
    print('Exception when calling PasswordApi->authControllerResetPasswordOtpVerification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **resetPasswordVerificationDTO** | [**ResetPasswordVerificationDTO**](ResetPasswordVerificationDTO.md)|  | 

### Return type

[**ResetPasswordOTPVerificationResponsePayload**](ResetPasswordOTPVerificationResponsePayload.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

