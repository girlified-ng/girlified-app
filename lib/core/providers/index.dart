import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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

  static AuthenticationService authenticationService =
      Get.find<AuthenticationService>();
}
