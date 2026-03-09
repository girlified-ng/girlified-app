import 'dart:async';
import 'dart:developer';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/timers.dart';
import 'package:girlified/core/constants/navigation.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:auth_sdk/auth_sdk.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/buttons/resend_otp_button.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';
import 'package:girlified/components/buttons/custom_auth_back_button.dart';

class ForgotPasswordOtpVerificationScreen extends StatefulWidget {
  const ForgotPasswordOtpVerificationScreen({super.key});

  @override
  State<ForgotPasswordOtpVerificationScreen> createState() =>
      _ForgotPasswordOtpVerificationScreenState();
}

class _ForgotPasswordOtpVerificationScreenState
    extends State<ForgotPasswordOtpVerificationScreen> {
  late Timer _countDownTimer;
  int _countDown = AppTimerConstants.resendOtpTimer_180;

  bool hidePassword = true;
  RxBool isOtpValid = false.obs;

  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController otpController;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    formKey = GlobalKey<FormState>();
    otpController = TextEditingController();

    startTimer();
  }

  @override
  void dispose() {
    focusNode.dispose();
    otpController.dispose();
    _countDownTimer.cancel();

    super.dispose();
  }

  void startTimer() {
    _countDownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown--;
        } else {
          _countDownTimer.cancel();
        }
      });
    });
  }

  String get countDownText {
    final minutes = (_countDown ~/ 60).toString().padLeft(2, '0');
    final seconds = (_countDown % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  Future<void> handleResendOtp() async {
    if (_countDown != 0 ||
        ServiceRegistry
            .authenticationService.isForgotPasswordProcessing.isTrue) {
      return;
    }

    ForgotPasswordDTO formData = ForgotPasswordDTO(
      (instance) => instance..email = Get.parameters['email'],
    );

    await ServiceRegistry.authenticationService.forgotPasswordService(formData);

    if (ServiceRegistry
        .authenticationService.isForgotPasswordProcessing.isTrue) {
      setState(() {
        _countDown = AppTimerConstants.resendOtpTimer_180;
      });

      startTimer();
    }
  }

  void submitHandler() async {
    if (ServiceRegistry
        .authenticationService.isForgotPasswordProcessing.isTrue) {
      return;
    }

    if (isOtpValid.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Invalid OTP',
      );
    } else {
      ResetPasswordVerificationDTO payload = ResetPasswordVerificationDTO(
        (instance) => instance
          ..email = Get.parameters['email']
          ..otp = otpController.text.trim(),
      );

      ServiceRegistry.authenticationService
          .resetPasswordOtpVerificationService(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: AppColors.textColor,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.borderPrimaryColor),
      ),
    );

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
                      const CustomAuthBackButton(
                        navigateTo: AuthNavigationTypes.authSignIn,
                      ),
                      const SizedBox(height: AppSizes.vertical_15),
                      TitleText(
                        size: 20,
                        title: 'Enter OTP Code',
                      ),
                      const SizedBox(height: AppSizes.vertical_5),
                      RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Please enter the 4 digit code we sent to',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: AppColors.textTertiaryColor,
                              ),
                            ),
                            TextSpan(
                              text: '${Get.parameters['email']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                                color: AppColors.blackColor,
                              ),
                            ),
                            const TextSpan(
                              text: 'via Email',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w400,
                                color: AppColors.textTertiaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSizes.vertical_20),
                      SizedBox(
                        width: double.maxFinite,
                        child: Directionality(
                          // Specify direction if desired
                          textDirection: TextDirection.ltr,
                          child: Pinput(
                            controller: otpController,
                            focusNode: focusNode,
                            defaultPinTheme: defaultPinTheme,
                            separatorBuilder: (index) =>
                                const SizedBox(width: 8),
                            hapticFeedbackType: HapticFeedbackType.lightImpact,
                            onCompleted: (pin) {
                              log('onCompleted: $pin');

                              isOtpValid.value = true;
                            },
                            onChanged: (value) {
                              log('onChanged: $value');
                            },
                            cursor: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(bottom: 9),
                                  width: 22,
                                  height: 1,
                                  color: AppColors.borderPrimaryColor,
                                ),
                              ],
                            ),
                            focusedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.borderPrimaryColor,
                                ),
                              ),
                            ),
                            submittedPinTheme: defaultPinTheme.copyWith(
                              decoration: defaultPinTheme.decoration!.copyWith(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(19),
                                border: Border.all(
                                  color: AppColors.borderPrimaryColor,
                                ),
                              ),
                            ),
                            errorPinTheme: defaultPinTheme.copyBorderWith(
                              border: Border.all(color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.horizontal_15),
                      ResendOtpButton(
                        countDownText: countDownText,
                        hasCountDown: _countDown > 0,
                        onTapOtpHandler: handleResendOtp,
                        isLoading: ServiceRegistry.authenticationService
                            .isForgotPasswordProcessing.isTrue,
                      ),
                      const SizedBox(height: AppSizes.horizontal_15),
                      ServiceRegistry.authenticationService
                              .isResetPasswordOtpVerificationProcessing.isTrue
                          ? const CustomLoadingButton(height: 56)
                          : CustomButton(
                              text: 'Verify',
                              width: double.maxFinite,
                              height: 56,
                              fontSize: 16,
                              borderRadius: 16,
                              onTapHandler: submitHandler,
                              fontWeight: FontWeight.w600,
                              fontColor: AppColors.whiteColor,
                              backgroundColor: isOtpValid.isFalse
                                  ? AppColors.buttonPrimaryDisabledColor
                                  : AppColors.buttonPrimaryColor,
                            ),
                      const SizedBox(height: AppSizes.horizontal_25),
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
