import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/middlewares/index.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/form/form_phone_field.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/form/form_password_field.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:account_sdk/account_sdk.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';

class UpdateAccountPhoneNumberScreen extends StatefulWidget {
  const UpdateAccountPhoneNumberScreen({super.key});

  @override
  State<UpdateAccountPhoneNumberScreen> createState() =>
      _UpdateAccountPhoneNumberScreenState();
}

class _UpdateAccountPhoneNumberScreenState
    extends State<UpdateAccountPhoneNumberScreen> {
  bool hidePassword = true;
  RxBool isPhoneNumberValid = false.obs;

  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void initializeControllersContent() async {
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      if (ServiceRegistry.userRepository.accountInfo.value.phone.isNotEmpty) {
        phoneController.text = ServiceRegistry
            .userRepository.accountInfo.value.phone
            .split('+234')[1];
      }
    });
  }

  @override
  void initState() {
    initializeControllersContent();

    super.initState();

    phoneController.addListener(() {
      if (phoneController.text.length == 10) {
        isPhoneNumberValid.value = true;
      } else {
        isPhoneNumberValid.value = false;
      }
    });
  }

  void handleSubmit() {
    if (passwordController.text.isEmpty) {
      return customErrorMessageSnackbar(
          title: 'Message',
          message: 'Account password is required',
          );
    } else if (ServiceRegistry.commonRepository.userCountry.value.dialCode !=
        '+234') {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Invalid country code',
      );
    } else if (isPhoneNumberValid.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Phone number must be atleast 10 digits',
      );
    } else if (!phoneController.text.isNumericOnly) {
      return customErrorMessageSnackbar(
          duration: 5500,
          title: 'Message',
          message: 'Invalid phone number, ensure that your phone number comprises of digits only!',
          );
    } else {
      UpdateAccountPhoneDTO payload = UpdateAccountPhoneDTO(
        (instance) => instance
          ..password = passwordController.text.trim()
          ..newPhone = formatPhoneNumber(
            ServiceRegistry.commonRepository.userCountry.value.dialCode!,
            phoneController.text.trim(),
          ),
      );

      ServiceRegistry.accountService.updateUserAccountPhoneNumberService(
        payload,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: SafeArea(
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
                  title: 'Phone Number',
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
              FormPhoneField(phoneController: phoneController),
              const SizedBox(height: AppSizes.vertical_10),
              FormPasswordField(
                showSuffixIcon: true,
                label: 'Password',
                hintText: 'Enter account password',
                hidePassword: hidePassword,
                passwordController: passwordController,
              ),
              const SizedBox(height: AppSizes.vertical_20),
              Obx(
                () {
                  return ServiceRegistry
                          .accountService.isUpdateAccountInfoProcessing.isTrue
                      ? const CustomLoadingButton(height: 56)
                      : CustomButton(
                          text: 'Update Phone Number',
                          width: double.maxFinite,
                          height: 56,
                          fontSize: 16,
                          borderRadius: 16,
                          onTapHandler: handleSubmit,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.whiteColor,
                          backgroundColor: (isPhoneNumberValid.isFalse)
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
