import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/form/form_text_field.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:account_sdk/account_sdk.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';

class UpdateAccountNameScreen extends StatefulWidget {
  const UpdateAccountNameScreen({super.key});

  @override
  State<UpdateAccountNameScreen> createState() =>
      _UpdateAccountNameScreenState();
}

class _UpdateAccountNameScreenState extends State<UpdateAccountNameScreen> {
  RxBool isLastNameValid = false.obs;
  RxBool isFirstNameValid = false.obs;

  TextEditingController lastNameController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();

  void initializeControllersContent() async {
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      firstNameController.text =
          ServiceRegistry.userRepository.accountInfo.value.firstName;
      lastNameController.text =
          ServiceRegistry.userRepository.accountInfo.value.lastName;
    });
  }

  @override
  void initState() {
    initializeControllersContent();

    super.initState();

    firstNameController.addListener(() {
      if (firstNameController.text.length > 2) {
        isFirstNameValid.value = true;
      } else {
        isFirstNameValid.value = false;
      }
    });
    lastNameController.addListener(() {
      if (lastNameController.text.length > 2) {
        isLastNameValid.value = true;
      } else {
        isLastNameValid.value = false;
      }
    });
  }

  void submitHandler() {
    if (firstNameController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'First name is required',
      );
    } else if (lastNameController.text.isEmpty) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Last name is required',
      );
    } else {
      UpdateAccountNameDTO payload = UpdateAccountNameDTO(
        (instance) => instance
          ..firstName = firstNameController.text.trim()
          ..lastName = lastNameController.text.trim(),
      );

      ServiceRegistry.accountService.updateUserAccountNameService(payload);
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
                  title: 'Account Name',
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
                label: 'First Name',
                hintText: 'e.g Kunle',
                textController: firstNameController,
              ),
              const SizedBox(height: AppSizes.vertical_20),
              FormTextField(
                label: 'Last Name',
                hintText: 'e.g Ahmed',
                textController: lastNameController,
              ),
              const SizedBox(height: AppSizes.vertical_20),
              Obx(
                () {
                  return ServiceRegistry
                          .accountService.isUpdateAccountInfoProcessing.isTrue
                      ? const CustomLoadingButton(height: 56)
                      : CustomButton(
                          text: 'Update Name',
                          width: double.maxFinite,
                          height: 56,
                          fontSize: 16,
                          borderRadius: 16,
                          onTapHandler: submitHandler,
                          fontWeight: FontWeight.w600,
                          fontColor: AppColors.whiteColor,
                          backgroundColor: (isLastNameValid.isFalse ||
                                  isFirstNameValid.isFalse)
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
