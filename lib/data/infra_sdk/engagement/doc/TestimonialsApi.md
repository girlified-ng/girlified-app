# engagement_sdk.api.TestimonialsApi

## Load the API package
```dart
import 'package:engagement_sdk/api.dart';
```

All URIs are relative to *https://infra-girlified.livestocx.xyz*

Method | HTTP request | Description
------------- | ------------- | -------------
[**engagementControllerFetchTestimonialsFeed**](TestimonialsApi.md#engagementcontrollerfetchtestimonialsfeed) | **GET** /v1/engagement/testimonials/feed | 


# **engagementControllerFetchTestimonialsFeed**
> BuiltList<TestimonialInfo> engagementControllerFetchTestimonialsFeed()



### Example
```dart
import 'package:engagement_sdk/api.dart';

final api = EngagementSdk().getTestimonialsApi();

try {
    final response = api.engagementControllerFetchTestimonialsFeed();
    print(response);
} catch on DioException (e) {
    print('Exception when calling TestimonialsApi->engagementControllerFetchTestimonialsFeed: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**BuiltList&lt;TestimonialInfo&gt;**](TestimonialInfo.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

