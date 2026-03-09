import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:auth_sdk/auth_sdk.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/form/form_password_field.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';
import 'package:girlified/components/buttons/custom_auth_back_button.dart';
import 'package:girlified/components/buttons/show_hide_password_button.dart';
import 'package:girlified/components/indicators/password_strength_indicator.dart';

class SignupCreatePasswordScreen extends StatefulWidget {
  const SignupCreatePasswordScreen({super.key});

  @override
  State<SignupCreatePasswordScreen> createState() =>
      _SignupCreatePasswordScreenState();
}

class _SignupCreatePasswordScreenState
    extends State<SignupCreatePasswordScreen> {
  bool hidePassword = true;
  RxInt passwordStrength = 0.obs;
  RxBool showPassword = true.obs;
  RxBool isPasswordValid = false.obs;
  RxBool passwordHasNumber = false.obs;
  RxInt confirmPasswordStrength = 0.obs;
  RxBool passwordHasUppercase = false.obs;

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    passwordController.addListener(() {
      if (passwordController.text.length >= 8) {
        isPasswordValid.value = true;
      } else {
        isPasswordValid.value = false;
      }

      if (passwordController.text.contains(RegExp(r'[0-9]'))) {
        passwordHasNumber.value = true;
      } else {
        passwordHasNumber.value = false;
      }

      if (passwordController.text.contains(RegExp(r'[A-Z]'))) {
        passwordHasUppercase.value = true;
      } else {
        passwordHasUppercase.value = false;
      }

      passwordStrength.value = passwordController.text.length;
    });

    confirmPasswordController.addListener(() {
      confirmPasswordStrength.value = confirmPasswordController.text.length;
    });
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  void submitHandler() async {
    if (passwordController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Password is required',
      );
    } else if (passwordStrength.value < 8) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Password must be at least 8 characters',
      );
    } else if (passwordHasUppercase.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Password must have at least 1 uppercase',
      );
    } else if (passwordHasNumber.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Password must have at least 1 number',
      );
    } else if (confirmPasswordController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Confirm Password is required',
      );
    } else if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Passwords do not match',
      );
    } else {
      CreateAccountDTO payload = CreateAccountDTO((instance) => instance
        ..email = Get.parameters['email']
        ..phone = Get.parameters['phone']
        ..lastName = Get.parameters['lastName']
        ..firstName = Get.parameters['firstName']
        ..password = passwordController.text.trim());

      ServiceRegistry.authenticationService.signUpService(payload: payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            width: AppSizes.screenWidth(context),
            height: AppSizes.screenHeight(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage(
                  'assets/images/image_background_2.jpg',
                ),
                fit: AppSizes.screenWidth(context) > 600 ? BoxFit.cover : null,
              ),
            ),
          ),
        ),
        Scaffold(
          extendBody: true,
          backgroundColor: Colors.transparent,
          body: Obx(() {
            return SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontal_15,
                  ),
                  width: double.maxFinite,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSizes.vertical_30),
                      const CustomAuthBackButton(),
                      const SizedBox(height: AppSizes.vertical_15),
                      TitleText(
                        size: 20,
                        title: 'Create Password',
                      ),
                      SubtitleText(
                        color: AppColors.textTertiaryColor,
                        text: 'Add a way to secure your password',
                      ),
                      const SizedBox(height: AppSizes.vertical_20),
                      FormPasswordField(
                        label: 'Password',
                        hintText: '*********',
                        hidePassword: hidePassword,
                        passwordController: passwordController,
                      ),
                      const SizedBox(height: AppSizes.vertical_10),
                      FormPasswordField(
                        label: 'Confirm Password',
                        hintText: '*********',
                        hidePassword: hidePassword,
                        passwordController: confirmPasswordController,
                      ),
                      const SizedBox(height: AppSizes.horizontal_15),
                      ShowHidePasswordButton(
                        showPassword: showPassword.value,
                        onTapHandler: () {
                          setState(() {
                            hidePassword = !hidePassword;
                            showPassword.value = !showPassword.value;
                          });
                        },
                      ),
                      const SizedBox(height: AppSizes.horizontal_15),
                      ServiceRegistry
                              .authenticationService.isSignUpProcessing.isTrue
                          ? const CustomLoadingButton(height: 56)
                          : CustomButton(
                              height: 56,
                              fontSize: 16,
                              text: 'Continue',
                              borderRadius: 16,
                              width: double.maxFinite,
                              onTapHandler: submitHandler,
                              fontWeight: FontWeight.w600,
                              fontColor: AppColors.whiteColor,
                              backgroundColor: isPasswordValid.isFalse
                                  ? AppColors.buttonPrimaryDisabledColor
                                  : AppColors.buttonPrimaryColor,
                            ),
                      const SizedBox(height: AppSizes.horizontal_15),
                      PasswordStrengthIndicator(
                        passwordStrength: passwordStrength,
                        passwordHasNumber: passwordHasNumber,
                        passwordHasUppercase: passwordHasUppercase,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
