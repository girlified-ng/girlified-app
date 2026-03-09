# account_sdk.api.UploadApi

## Load the API package
```dart
import 'package:account_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**imageUploadControllerUploadFile**](UploadApi.md#imageuploadcontrolleruploadfile) | **POST** /v1/account/upload/file | Upload an file
[**imageUploadControllerUploadImage**](UploadApi.md#imageuploadcontrolleruploadimage) | **POST** /v1/account/upload/image | Upload an image with optional resizing


# **imageUploadControllerUploadFile**
> FileUploadResult imageUploadControllerUploadFile(file)

Upload an file

### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getUploadApi();
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.imageUploadControllerUploadFile(file);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UploadApi->imageUploadControllerUploadFile: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**FileUploadResult**](FileUploadResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **imageUploadControllerUploadImage**
> FileUploadResult imageUploadControllerUploadImage(type, file)

Upload an image with optional resizing

### Example
```dart
import 'package:account_sdk/api.dart';

final api = AccountSdk().getUploadApi();
final String type = type_example; // String | 
final MultipartFile file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final response = api.imageUploadControllerUploadImage(type, file);
    print(response);
} catch on DioException (e) {
    print('Exception when calling UploadApi->imageUploadControllerUploadImage: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **type** | **String**|  | [optional] 
 **file** | **MultipartFile**|  | [optional] 

### Return type

[**FileUploadResult**](FileUploadResult.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

