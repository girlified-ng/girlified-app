import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';
import 'package:girlified/components/form/form_text_field.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:account_sdk/account_sdk.dart';

class UpdateAccountEmailScreen extends StatefulWidget {
  const UpdateAccountEmailScreen({super.key});

  @override
  State<UpdateAccountEmailScreen> createState() =>
      _UpdateAccountEmailScreenState();
}

class _UpdateAccountEmailScreenState extends State<UpdateAccountEmailScreen> {
  RxBool isEmailValid = false.obs;

  TextEditingController emailController = TextEditingController();

  void initializeControllersContent() async {
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      emailController.text =
          ServiceRegistry.userRepository.accountInfo.value.email;
    });
  }

  @override
  void initState() {
    initializeControllersContent();

    super.initState();

    emailController.addListener(() {
      if (emailController.text.isEmail) {
        isEmailValid.value = true;
      } else {
        isEmailValid.value = false;
      }
    });
  }

  void handleSubmit() {
    if (isEmailValid.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Invalid email address',
      );
    } else {
      UpdateAccountEmailDTO payload = UpdateAccountEmailDTO(
        (instance) => instance..newEmail = emailController.text.trim(),
      );

      // ServiceRegistry.accountService.updateUserAccountEmailService(
      //   payload,
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SafeArea(
          // padding: MediaQuery.of(context).padding,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontal_15,
            ),
            child: Row(
              children: [
                const CustomBackButton(),
                const SizedBox(width: AppSizes.horizontal_10),
                TitleText(
                  size: 20,
                  title: 'Email Address',
                  weight: FontWeight.w700,
                ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppSizes.vertical_20),
              FormTextField(
                label: 'Email Address',
                hintText: 'tunde@gmail.com',
                textController: emailController,
              ),
              const SizedBox(height: AppSizes.vertical_20),
              Obx(
                () {
                  return ServiceRegistry
                          .accountService.isUpdateAccountInfoProcessing.isTrue
                      ? const CustomLoadingButton(height: 56)
                      : CustomButton(
                          text: 'Update Email',
                          width: double.maxFinite,
                          height: 56,
                          fontSize: 16,
                          borderRadius: 16,
                          onTapHandler: handleSubmit,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.whiteColor,
                          backgroundColor: (isEmailValid.isFalse)
                              ? AppColors.buttonPrimaryDisabledColor
                              : AppColors.buttonPrimaryColor,
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
