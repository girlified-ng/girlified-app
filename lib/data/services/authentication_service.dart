import 'dart:developer';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as Dio;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationService extends GetxController {
  RxBool isSignInProcessing = false.obs;
  RxBool isSignUpProcessing = false.obs;
  RxBool isResetPasswordProcessing = false.obs;
  RxBool isForgotPasswordProcessing = false.obs;
  RxBool isResendSignUpOTPSuccessful = false.obs;
  RxBool isResetPasswordOtpVerificationProcessing = false.obs;

  var email = ''.obs;
  var password = ''.obs;

  Future<void> signInService(String userEmail, String userPassword) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('email', userEmail);
    await prefs.setString('password', userPassword);

    email.value = userEmail;
    password.value = userPassword;

    // Get.offAllNamed('/dashboard');
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('email') ?? '';
    password.value = prefs.getString('password') ?? '';
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Get.offAllNamed('/login');
  }

  
}
