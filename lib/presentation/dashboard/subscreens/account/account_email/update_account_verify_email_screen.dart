import 'dart:async';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/timers.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/buttons/resend_otp_button.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';
import 'package:account_sdk/account_sdk.dart';

class UpdateAccountVerifyEmailScreen extends StatefulWidget {
  const UpdateAccountVerifyEmailScreen({super.key});

  @override
  State<UpdateAccountVerifyEmailScreen> createState() =>
      _UpdateAccountVerifyEmailScreenState();
}

class _UpdateAccountVerifyEmailScreenState
    extends State<UpdateAccountVerifyEmailScreen> {
  bool hidePassword = true;

  RxBool isOtpValid = false.obs;

  late final FocusNode focusNode;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController otpTokenController;

  late Timer _countDownTimer;
  int _countDown = AppTimerConstants.resendOtpTimer_180;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
    formKey = GlobalKey<FormState>();
    otpTokenController = TextEditingController();

    startTimer();
  }

  @override
  void dispose() {
    focusNode.dispose();
    otpTokenController.dispose();
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

  void submitHandler() async {
    if (isOtpValid.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Invalid OTP',
      );
    } else {
      VerifyNewAccountEmailDTO payload = VerifyNewAccountEmailDTO(
        (instance) => instance..otp = otpTokenController.text.trim(),
      );

      ServiceRegistry.accountService.verifyNewAccountEmailService(payload);
    }
  }

  Future<void> handleResendOtp() async {
    if (_countDown != 0 ||
        ServiceRegistry.accountService.isUpdateAccountInfoProcessing.isTrue) {
      return;
    }

    UpdateAccountEmailDTO payload = UpdateAccountEmailDTO(
      (instance) => instance..newEmail = Get.parameters['email']!,
    );

    await ServiceRegistry.accountService.updateUserAccountEmailService(
      payload,
      resendOtp: true,
    );

    if (ServiceRegistry
        .accountService.isResendUpdateAccountInfoOtpProcessing.isTrue) {
      setState(() {
        _countDown = AppTimerConstants.resendOtpTimer_180;
      });

      startTimer();
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

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: MediaQuery.of(context).padding,
            child: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontal_15,
              ),
              child: const Row(
                children: [
                  CustomBackButton(),
                ],
              ),
            ),
          ),
        ),
        body: Obx(() {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontal_10,
                ),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const CustomAuthBackButton(),
                    const SizedBox(height: AppSizes.vertical_15),
                    TitleText(
                      size: 20,
                      title: 'Verify Your Email',
                    ),
                    const SizedBox(height: AppSizes.vertical_5),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Please enter the 4 digit code we sent to ',
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
                          controller: otpTokenController,
                          focusNode: focusNode,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => const SizedBox(
                            width: AppSizes.horizontal_5,
                          ),
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
                      onTapOtpHandler: handleResendOtp,
                      countDownText: countDownText,
                      hasCountDown: _countDown > 0,
                      // text:
                      //     'Resend code ${_countDown > 0 ? "in $countDownText" : ""}',
                    ),
                    const SizedBox(height: AppSizes.horizontal_15),
                    ServiceRegistry
                            .accountService.isUpdateAccountInfoProcessing.isTrue
                        ? const CustomLoadingButton(height: 50)
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
    );
  }
}
