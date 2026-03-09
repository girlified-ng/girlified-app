# account_sdk.api.NotificationsApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**accountNotificationControllerGetNotifications**](NotificationsApi.md#accountnotificationcontrollergetnotifications) | **GET** /v1/account/notifications | 
[**accountNotificationControllerReadNotification**](NotificationsApi.md#accountnotificationcontrollerreadnotification) | **PATCH** /v1/account/notifications/read | 


# **accountNotificationControllerGetNotifications**
> NotificationsResponse accountNotificationControllerGetNotifications(page, pageSize)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getNotificationsApi();
final num page = 1; // num | 
final num pageSize = 20; // num | 

try {
    final response = api.accountNotificationControllerGetNotifications(page, pageSize);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->accountNotificationControllerGetNotifications: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **page** | **num**|  | [optional] 
 **pageSize** | **num**|  | [optional] 

### Return type

[**NotificationsResponse**](NotificationsResponse.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **accountNotificationControllerReadNotification**
> NotificationInfo accountNotificationControllerReadNotification(notificationId)



### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getNotificationsApi();
final num notificationId = 1; // num | 

try {
    final response = api.accountNotificationControllerReadNotification(notificationId);
    print(response);
} catch on DioException (e) {
    print('Exception when calling NotificationsApi->accountNotificationControllerReadNotification: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **notificationId** | **num**|  | [optional] 

### Return type

[**NotificationInfo**](NotificationInfo.md)

### Authorization

[bearer](../README.md#bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

