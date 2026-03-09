import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/components/text/custom_text_widget.dart';
import 'package:account_sdk/account_sdk.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DeleteAccountConfirmationModal extends StatelessWidget {
  final String password;
  const DeleteAccountConfirmationModal({
    super.key,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      shadowColor: AppColors.whiteColor,
      backgroundColor: AppColors.backgroundColor,
      content: Container(
        height: 120,
        width: double.maxFinite,
        padding: const EdgeInsets.only(
          top: AppSizes.horizontal_20,
        ),
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontal_20,
              ),
              child: Column(
                children: [
                  CustomTextWidget(
                    size: 16,
                    weight: FontWeight.w600,
                    alignment: TextAlign.center,
                    textStyleName: AppTextSizes.bodyText3,
                    text: 'Are you sure to want to delete your account?',
                  ),
                ],
              ),
            ),
            Container(
              height: 44,
              width: double.maxFinite,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: AppColors.grayLightColor,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (ServiceRegistry.accountService
                            .isDeleteUserAccountProcessing.isTrue) {
                          return;
                        }

                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: double.maxFinite,
                        decoration: const BoxDecoration(
                          border: Border(
                            right: BorderSide(
                              color: AppColors.grayLightColor,
                            ),
                          ),
                        ),
                        child: Center(
                          child: CustomTextWidget(
                            size: 17,
                            text: 'Cancel',
                            weight: FontWeight.w400,
                            textStyleName: AppTextSizes.title3,
                            color: AppColors.redColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        if (ServiceRegistry.accountService
                            .isDeleteUserAccountProcessing.isTrue) {
                          return;
                        }

                        DeleteAccountDTO payload = DeleteAccountDTO(
                          (instance) => instance..password = password,
                        );

                        ServiceRegistry.accountService.deleteUserAccountService(
                          payload,
                          context,
                        );
                      },
                      child: SizedBox(
                        height: double.maxFinite,
                        child: Center(
                          child: Obx(
                            () {
                              return ServiceRegistry.accountService
                                      .isDeleteUserAccountProcessing.isTrue
                                  ? LoadingAnimationWidget.hexagonDots(
                                      size: 20,
                                      color: AppColors.buttonPrimaryColor,
                                    )
                                  : CustomTextWidget(
                                      size: 17,
                                      text: 'Yes',
                                      weight: FontWeight.w400,
                                      color: AppColors.greenColor,
                                      textStyleName: AppTextSizes.title3,
                                    );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
