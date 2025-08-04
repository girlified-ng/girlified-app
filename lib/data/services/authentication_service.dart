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

class AuthenticationService extends GetxController {
  RxBool isSignInProcessing = false.obs;
  RxBool isSignUpProcessing = false.obs;
  RxBool isResetPasswordProcessing = false.obs;
  RxBool isForgotPasswordProcessing = false.obs;
  RxBool isResendSignUpOTPSuccessful = false.obs;
  RxBool isResetPasswordOtpVerificationProcessing = false.obs;
}
