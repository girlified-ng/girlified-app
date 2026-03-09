// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:account_sdk/src/serializers.dart';
import 'package:account_sdk/src/auth/api_key_auth.dart';
import 'package:account_sdk/src/auth/basic_auth.dart';
import 'package:account_sdk/src/auth/bearer_auth.dart';
import 'package:account_sdk/src/auth/oauth.dart';
import 'package:account_sdk/src/api/manage_contact_info_api.dart';
import 'package:account_sdk/src/api/me_api.dart';
import 'package:account_sdk/src/api/monthly_survey_api.dart';
import 'package:account_sdk/src/api/notifications_api.dart';
import 'package:account_sdk/src/api/order_api.dart';
import 'package:account_sdk/src/api/protection_api.dart';
import 'package:account_sdk/src/api/support_api.dart';
import 'package:account_sdk/src/api/upload_api.dart';

class AccountSdk {
  static const String basePath = r'https://infra-girlified.livestocx.xyz';

  final Dio dio;
  final Serializers serializers;

  AccountSdk({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get ManageContactInfoApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ManageContactInfoApi getManageContactInfoApi() {
    return ManageContactInfoApi(dio, serializers);
  }

  /// Get MeApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MeApi getMeApi() {
    return MeApi(dio, serializers);
  }

  /// Get MonthlySurveyApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MonthlySurveyApi getMonthlySurveyApi() {
    return MonthlySurveyApi(dio, serializers);
  }

  /// Get NotificationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NotificationsApi getNotificationsApi() {
    return NotificationsApi(dio, serializers);
  }

  /// Get OrderApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  OrderApi getOrderApi() {
    return OrderApi(dio, serializers);
  }

  /// Get ProtectionApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ProtectionApi getProtectionApi() {
    return ProtectionApi(dio, serializers);
  }

  /// Get SupportApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SupportApi getSupportApi() {
    return SupportApi(dio, serializers);
  }

  /// Get UploadApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UploadApi getUploadApi() {
    return UploadApi(dio, serializers);
  }
}
