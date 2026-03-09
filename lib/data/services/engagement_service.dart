// ignore_for_file: library_prefixes, use_build_context_synchronously
import 'dart:core';
import 'dart:developer';
import 'package:built_collection/built_collection.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:girlified/core/middlewares/index.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:engagement_sdk/engagement_sdk.dart' as EngagementSdk;
import 'package:girlified/data/services/guards/auth_guard.dart';

class EngagementService extends GetxController {
  //! FETCH-TESTIMONIALS-FEED
  ///
  /// METHOD: GET
  ///
  /// [ROUTE] - /communication/testimonials/feed
  Future<void> fetchTestimonialsService() async {
    return authGuard<void>(() async {
      try {
        log("[FETCH-TESTIMONIALS-FEED-PENDING]");

        List<String> imageUrls = [];

        EngagementSdk.TestimonialsApi testimonialsApi =
            ServiceRegistry.engagementSdk.getTestimonialsApi();

        Dio.Response response =
            await testimonialsApi.engagementControllerFetchTestimonialsFeed();

        if (response.statusCode == 200) {
          log('[FETCH-TESTIMONIALS-FEED-RESPONSE] :: ${response.data}');

          BuiltList<EngagementSdk.TestimonialInfo> data = response.data;

          ServiceRegistry.userRepository.testimonials.value = data.toList();

          for (var testimonial in data) {
            imageUrls.add(testimonial.avatarUrl!);
          }

          preCacheNetworkImages(imageUrls);

          log("[FETCH-TESTIMONIALS-FEED-SUCCESS]");
        }
      } catch (error) {
        log('[FETCH-TESTIMONIALS-FEED-ERROR-RESPONSE] :: $error');

        if (error is Dio.DioException) {
          Dio.DioException dioError = error;

          log('[FETCH-TESTIMONIALS-FEED-DIO-ERROR-RESPONSE] :: ${dioError.response}');
        }
      }
    });
  }
}
