import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:auth_sdk/auth_sdk.dart';
import 'package:account_sdk/account_sdk.dart';
import 'package:engagement_sdk/src/api.dart';
import 'package:girlified/data/services/account_service.dart';
import 'package:girlified/data/services/engagement_service.dart';
import 'package:girlified/data/services/order_service.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:girlified/data/repositories/user_repository.dart';
import 'package:girlified/data/repositories/common_repository.dart';
import 'package:girlified/data/services/authentication_service.dart';

class ServiceRegistry {
  static Dio dioBaseOptions = Dio(BaseOptions(
    // baseUrl: dotenv.env['INFRA_BASE_URL']!,
    baseUrl: dotenv.env['INFRA_PROD_URL']!,
    sendTimeout: const Duration(milliseconds: 15000),
    connectTimeout: const Duration(milliseconds: 15000),
    receiveTimeout: const Duration(milliseconds: 15000),
  ));

  static GetStorage localStorage = GetStorage();
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static UserRepository userRepository = Get.find<UserRepository>();
  static CommonRepository commonRepository = Get.find<CommonRepository>();

  static OrderService orderService = Get.find<OrderService>();

  static AccountService accountService = Get.find<AccountService>();

  static EngagementService engagementService = Get.find<EngagementService>();

  static AuthenticationService authenticationService =
      Get.find<AuthenticationService>();

  static AuthSdk authSdk = AuthSdk(
    dio: dioBaseOptions,
    // basePathOverride: dotenv.env['INFRA_BASE_URL']!,
    basePathOverride: dotenv.env['INFRA_PROD_URL']!,
    // basePathOverride: dotenv.env['INFRA_LOCAL_HOST_URL']!,
  );

  static AccountSdk accountSdk = AccountSdk(
    dio: dioBaseOptions,
    // basePathOverride: dotenv.env['INFRA_BASE_URL']!,
    basePathOverride: dotenv.env['INFRA_PROD_URL']!,
    // basePathOverride: dotenv.env['INFRA_LOCAL_HOST_URL']!,
  );

  static EngagementSdk engagementSdk = EngagementSdk(
    dio: dioBaseOptions,
    // basePathOverride: dotenv.env['INFRA_BASE_URL']!,
    basePathOverride: dotenv.env['INFRA_PROD_URL']!,
    // basePathOverride: dotenv.env['INFRA_LOCAL_HOST_URL']!,
  );
}
