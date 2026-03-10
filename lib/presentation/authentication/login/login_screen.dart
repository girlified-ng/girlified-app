import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/components/badges/girlified_icon_badge.dart';
import 'package:girlified/components/carousels/testimonial_carousel.dart';
import 'package:girlified/components/navigation/auth_redirect_link.dart';
import 'package:girlified/components/text/custom_text_widget.dart';
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
import 'package:auth_sdk/auth_sdk.dart';
import 'package:girlified/components/form/form_password_field.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/data/services/authentication_service.dart';
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

  final authController = Get.put(AuthenticationService());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initializeAuth() async {
    await Future.delayed(const Duration(milliseconds: 80));

    if (ServiceRegistry.localStorage.read(LocalStorageSecrets.accessToken) !=
        null) {
      Get.toNamed(AppRoutes.dashboardRoute);
    }
  }

  void initializeTestimonials() async {
    if (ServiceRegistry.userRepository.testimonials.isEmpty) {
      ServiceRegistry.engagementService.fetchTestimonialsService();
    }
  }

  @override
  void initState() {
    super.initState();

    initializeAuth();
    initializeTestimonials();

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
    if (!emailController.text.isEmail) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Invalid email address',
      );
    } else if (passwordController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Password is required',
      );
    } else {
      // authController.signInService(
      //   emailController.text.trim(),
      //   passwordController.text.trim(),
      // );

      SigninDTO formData = SigninDTO(
        (instance) => instance
          ..email = emailController.text.trim()
          ..password = passwordController.text.trim(),
      );

      ServiceRegistry.authenticationService.signInService(formData);

      // Get.toNamed(AppRoutes.dashboardRoute);
      // return customSuccessMessageSnackbar(
      //     title: 'Message', message: 'Login Successful');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        return Future.value();
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: AppSizes.screenWidth(context),
              height: AppSizes.screenHeight(context),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: const AssetImage(
                    'assets/images/image_background.jpg',
                  ),
                  fit:
                      AppSizes.screenWidth(context) > 600 ? BoxFit.cover : null,
                ),
              ),
            ),
          ),
          Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
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
                        const GirlifiedIconBadge(size: 40),
                        const SizedBox(height: AppSizes.vertical_15),
                        SubtitleText(
                          size: 20,
                          text: 'Welcome Back,',
                          weight: FontWeight.w600,
                        ),
                        const AuthRedirectLink(),
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
                                Get.toNamed(AppRoutes.forgotPasswordRoute);
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
                        const SizedBox(height: 20),
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
                        Visibility(
                          // visible: true,
                          visible: Platform.isIOS,
                          child: Column(
                            children: [
                              const SizedBox(height: AppSizes.horizontal_20),
                              Center(
                                child: InkWell(
                                  onTap: () {
                                    ServiceRegistry.localStorage.write(
                                      LocalStorageSecrets.authenticationMethod,
                                      'GUEST',
                                    );

                                    Get.offAndToNamed(AppRoutes.dashboardRoute);
                                  },
                                  overlayColor: const WidgetStatePropertyAll(
                                    Colors.transparent,
                                  ),
                                  child: CustomTextWidget(
                                    size: 16,
                                    weight: FontWeight.w600,
                                    text: 'Continue as Guest',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSizes.horizontal_30),
                        Visibility(
                          visible: ServiceRegistry
                              .userRepository.testimonials.isNotEmpty,
                          child: const TestimonialCarousel(
                            hasBorder: true,
                            titleSize: 14,
                            bodySize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
