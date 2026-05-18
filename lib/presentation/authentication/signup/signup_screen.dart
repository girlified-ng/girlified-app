import 'dart:io';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/middlewares/index.dart';
import 'package:girlified/components/text/small_text.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/form/form_text_field.dart';
import 'package:girlified/components/form/form_phone_field.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/badges/girlified_icon_badge.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';
import 'package:girlified/components/navigation/auth_redirect_link.dart';
import 'package:girlified/components/buttons/labeled_dropdown_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool hidePassword = true;
  String accountType = 'CUSTOMER';
  RxBool isEmailValid = false.obs;
  RxBool isPhoneNumberValid = false.obs;

  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController referralCodeController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();

  void initializeControllersAndStates() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (Get.parameters['email'] != null) {
      emailController.text = Get.parameters['email']!;
    }
  }

  @override
  void initState() {
    super.initState();

    initializeControllersAndStates();

    phoneController.addListener(() {
      if (phoneController.text.length >= 10) {
        isPhoneNumberValid.value = true;
      } else {
        isPhoneNumberValid.value = false;
      }
    });

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
    phoneController.dispose();
    lastNameController.dispose();
    firstNameController.dispose();
    referralCodeController.dispose();

    super.dispose();
  }

  void submitHandler() async {
    if (emailController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Email is required',
      );
    } else if (isEmailValid.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Invalid email address',
      );
    } else if (firstNameController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'First name is required',
      );
    } else if (lastNameController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Last name is required',
      );
    } else if (phoneController.text.isNotEmpty &&
        !phoneController.text.isNumericOnly) {
      return customErrorMessageSnackbar(
        duration: 5500,
        title: 'Message',
        message:
            'Invalid phone number. Ensure that your phone number comprises of digits only',
      );
    } else {
      Map<String, dynamic> payload = {
        "phone": phoneController.text.isNotEmpty
            ? formatPhoneNumber(
                ServiceRegistry.commonRepository.userCountry.value.dialCode!,
                phoneController.text.trim(),
              )
            : "",
        "email": emailController.text.trim(),
        "firstName": firstNameController.text.trim(),
        "lastName": lastNameController.text.trim(),
        // "state": stateController.text.trim(),
        // "city": cityController.text.trim(),
        "referralCode": referralCodeController.text.isNotEmpty
            ? referralCodeController.text.trim()
            : "",
      };

      ServiceRegistry.authenticationService
          .checkEmailPhoneAvailabilityService(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.toNamed(AppRoutes.loginRoute);

        return false;
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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(135),
              child: SafeArea(
                child: Container(
                  height: double.maxFinite,
                  width: double.maxFinite,
                  // color: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.horizontal_15,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.vertical_30),
                      GirlifiedIconBadge(size: 30),
                      SizedBox(height: AppSizes.vertical_15),
                      TitleText(
                        size: 20,
                        title: 'Let\'s get to know you',
                      ),
                      SizedBox(height: AppSizes.vertical_5),
                      AuthRedirectLink(routeType: 'LOGIN'),
                    ],
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontal_15,
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSizes.vertical_5),
                    FormTextField(
                      label: 'Email',
                      hintText: 'lisa@gmail.com',
                      textController: emailController,
                    ),
                    const SizedBox(height: AppSizes.vertical_10),
                    FormTextField(
                      label: 'First name',
                      hintText: 'Lisa',
                      textController: firstNameController,
                    ),
                    const SizedBox(height: AppSizes.vertical_10),
                    FormTextField(
                      label: 'Last name',
                      hintText: 'Olayinka',
                      textController: lastNameController,
                    ),
                    const SizedBox(height: AppSizes.vertical_10),
                    FormPhoneField(
                      label: 'Phone number',
                      phoneController: phoneController,
                    ),
                    const SizedBox(height: AppSizes.vertical_10),
                    FormTextField(
                      label: 'Referral code',
                      textController: referralCodeController,
                      hintText: 'Enter referral code',
                    ),
                    const SizedBox(height: AppSizes.horizontal_30),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(
                top: AppSizes.vertical_10,
                left: AppSizes.horizontal_15,
                right: AppSizes.horizontal_15,
                bottom: Platform.isAndroid
                    ? AppSizes.vertical_10
                    : AppSizes.vertical_25,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SmallText(
                        // maxLines: 10,
                        text: 'By continuing, you automatically accept our ',
                      ),
                      InkWell(
                        onTap: () {
                          launchExternalBrowserUrl(
                            'https://girlified.com.ng/terms-of-service',
                          );
                        },
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        child: SmallText(
                          // maxLines: 10,
                          weight: FontWeight.bold,
                          text: 'Terms and Conditions',
                        ),
                      ),
                      SmallText(
                        // maxLines: 10,
                        text: ' and ',
                      ),
                      InkWell(
                        onTap: () {
                          launchExternalBrowserUrl(
                            'https://girlified.com.ng/privacy-policy',
                          );
                        },
                        overlayColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        child: SmallText(
                          // maxLines: 10,
                          weight: FontWeight.bold,
                          text: 'Privacy Policy',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.vertical_10),
                  Obx(() {
                    return ServiceRegistry
                            .authenticationService.isSignUpProcessing.isTrue
                        ? const CustomLoadingButton(height: 56)
                        : CustomButton(
                            text: 'Continue',
                            width: double.maxFinite,
                            height: 56,
                            fontSize: 16,
                            borderRadius: 16,
                            onTapHandler: submitHandler,
                            fontWeight: FontWeight.w600,
                            fontColor: AppColors.whiteColor,
                            backgroundColor: isEmailValid.isFalse
                                ? AppColors.buttonPrimaryDisabledColor
                                : AppColors.buttonPrimaryColor,
                          );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
