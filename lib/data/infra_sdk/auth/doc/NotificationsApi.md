# auth_sdk.api.NotificationsApi

## Load the API package
```dart
import 'package:auth_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authHelperControllerSendTestNotification**](NotificationsApi.md#authhelpercontrollersendtestnotification) | **POST** /v1/auth/helper/notifications/test | 


# **authHelperControllerSendTestNotification**
> authHelperControllerSendTestNotification(fcmToken)



### Example
```dart
import 'package:auth_sdk/api.dart';

final api = AuthSdk().getNotificationsApi();
final String fcmToken = fcmToken_example; // String | FCM Token

try {
    api.authHelperControllerSendTestNotification(fcmToken);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->authHelperControllerSendTestNotification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **fcmToken** | **String**| FCM Token | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

