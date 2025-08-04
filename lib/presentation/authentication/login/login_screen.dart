import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/text/small_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/form/form_email_field.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/form/form_password_field.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool hidePassword = true;
  RxBool isEmailValid = false.obs;
  RxBool isPhoneNumberValid = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initializeAuth() async {
    await Future.delayed(const Duration(milliseconds: 80));

    if (ServiceRegistry.localStorage.read(LocalStorageSecrets.accessToken) !=
        null) {
      Get.toNamed(AppRoutes.dashboardRoute);
    }
  }

  @override
  void initState() {
    super.initState();

    initializeAuth();

    emailController.addListener(() {
      if (emailController.text.isEmail) {
        isEmailValid.value = true;
      } else {
        isEmailValid.value = false;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  void submitHandler() async {
    Get.toNamed(AppRoutes.dashboardRoute);

    // if (!emailController.text.isEmail) {
    //   return customErrorMessageSnackbar(
    //     title: 'Message',
    //     message: 'Invalid email address',
    //   );
    // } else if (passwordController.text.isEmpty) {
    //   return customErrorMessageSnackbar(
    //     title: 'Message',
    //     message: 'Password is required',
    //   );
    // } else {}
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        return Future.value();
      },
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: Obx(() {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontal_15,
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.vertical_100),
                    SubtitleText(
                      size: 20,
                      text: 'Welcome Back,',
                      weight: FontWeight.w600,
                    ),
                    SmallText(
                      text: 'Sign in to continue',
                    ),
                    const SizedBox(height: AppSizes.vertical_20),
                    FormEmailField(
                      label: 'Email Address',
                      hintText: 'ayomide@gmail.com',
                      textController: emailController,
                    ),
                    const SizedBox(height: AppSizes.vertical_10),
                    FormPasswordField(
                      label: 'Password',
                      hintText: '********',
                      showSuffixIcon: true,
                      hidePassword: hidePassword,
                      passwordController: passwordController,
                    ),
                    const SizedBox(height: AppSizes.vertical_20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // Get.toNamed(AppRoutes.forgotPasswordRoute);
                          },
                          overlayColor: const WidgetStatePropertyAll(
                            Colors.transparent,
                          ),
                          child: BodyText(
                            text: 'Forgot password?',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 150),
                    ServiceRegistry
                            .authenticationService.isSignInProcessing.isTrue
                        ? const CustomLoadingButton(height: 53)
                        : CustomButton(
                            text: 'Signin',
                            width: double.maxFinite,
                            height: 53,
                            fontSize: 16,
                            borderRadius: 16,
                            onTapHandler: submitHandler,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.whiteColor,
                            backgroundColor: isEmailValid.isFalse
                                ? AppColors.buttonPrimaryDisabledColor
                                : AppColors.buttonPrimaryColor,
                          ),
                    const SizedBox(height: AppSizes.horizontal_10),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
