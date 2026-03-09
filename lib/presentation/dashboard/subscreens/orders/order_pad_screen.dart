import 'dart:io';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/subtitle_text.dart';
import 'package:girlified/components/text/form_label_text.dart';
import 'package:girlified/components/form/form_text_field.dart';
import 'package:girlified/components/buttons/custom_button.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:account_sdk/account_sdk.dart';
import 'package:girlified/components/buttons/custom_loading_button.dart';

class OrderPadScreen extends StatefulWidget {
  const OrderPadScreen({super.key});

  @override
  State<OrderPadScreen> createState() => _OrderPadScreenState();
}

class _OrderPadScreenState extends State<OrderPadScreen> {
  int quantity = 1;
  RxBool isAddressValid = false.obs;
  String deliveryMethod = 'delivery';

  TextEditingController addressController = TextEditingController();
  TextEditingController buildingNumberController = TextEditingController();
  TextEditingController nearestLandMarkController = TextEditingController();

  @override
  void initState() {
    super.initState();

    addressController.addListener(() {
      if (addressController.text.length > 5) {
        isAddressValid.value = true;
      } else {
        isAddressValid.value = false;
      }
    });
  }

  void handleSubmit() {
    if (isAddressValid.isFalse) {
      return customErrorMessageSnackbar(
        title: 'Message',
        message: 'Address must be at least 5 characters',
      );
    } else if (addressController.text.isEmpty) {
      return customErrorMessageSnackbar(
        duration: 5500,
        title: 'Message',
        message: 'Address is required',
      );
    } else if (buildingNumberController.text.isEmpty) {
      return customErrorMessageSnackbar(
        duration: 5500,
        title: 'Message',
        message: 'Building number is required',
      );
    } else if (nearestLandMarkController.text.isEmpty) {
      return customErrorMessageSnackbar(
        duration: 5500,
        title: 'Message',
        message: 'Nearest landmark is required',
      );
    } else {
      OrderSanitaryPadDTO payload = OrderSanitaryPadDTO(
        (instance) => instance
          ..quantity = quantity
          ..address = addressController.text.trim()
          ..deliveryMethod = deliveryMethod.toUpperCase()
          ..buildingNumber = buildingNumberController.text.trim()
          ..nearestLandmark = nearestLandMarkController.text.trim(),
      );

      ServiceRegistry.orderService.createSanitaryPadOrderService(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150),
        child: SafeArea(
          // padding: MediaQuery.of(context).padding,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: const EdgeInsets.only(
              left: AppSizes.horizontal_15,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.whiteColor,
                  AppColors.grayLightColor,
                ],
              ),
            ),
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: AppSizes.vertical_10,
                  ),
                  child: const CustomBackButton(
                    backgroundColor: AppColors.whiteColor,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    width: 160,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/image_sanitary_pad_2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TitleText(
                    size: 20,
                    title: 'Order Sanitary Pad',
                  ),
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
              FormLabelText(
                text: 'Quantity',
                size: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (quantity > 1) {
                        setState(() {
                          quantity--;
                        });
                      }
                    },
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.grayLightColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.remove,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  SubtitleText(
                    text: '$quantity',
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    splashColor: Colors.transparent,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.grayLightColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.vertical_12),
              FormLabelText(
                text: 'Delivery Method',
                size: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio<String>(
                          value: 'delivery',
                          groupValue: deliveryMethod,
                          onChanged: (value) {
                            setState(() {
                              deliveryMethod = value!;
                            });
                          },
                          activeColor: AppColors.greenColor,
                        ),
                        SubtitleText(
                          text: 'Delivery',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio<String>(
                          value: 'pickup',
                          groupValue: deliveryMethod,
                          onChanged: (value) {
                            setState(() {
                              deliveryMethod = value!;
                            });
                          },
                          activeColor: AppColors.greenColor,
                        ),
                        SubtitleText(
                          text: 'Pickup',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.vertical_12),
              FormTextField(
                label: 'Address',
                hintText: 'e.g Abiola Adefemi Street',
                textController: addressController,
              ),
              const SizedBox(height: AppSizes.vertical_12),
              FormTextField(
                label: 'Building Number',
                hintText: 'e.g 12A',
                textController: buildingNumberController,
              ),
              const SizedBox(height: AppSizes.vertical_12),
              FormTextField(
                label: 'Nearest Landmark',
                hintText: 'e.g bank, hospital etc...',
                textController: nearestLandMarkController,
              ),
              const SizedBox(height: AppSizes.vertical_50),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () {
          return Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(
              top: AppSizes.vertical_10,
              left: AppSizes.horizontal_15,
              right: AppSizes.horizontal_15,
              bottom: Platform.isAndroid
                  ? AppSizes.vertical_10
                  : AppSizes.vertical_25,
            ),
            decoration: const BoxDecoration(
              color: AppColors.whiteColor,
            ),
            child: ServiceRegistry
                    .orderService.isCreateSanitaryPadOrderProcessing.value
                ? const CustomLoadingButton(
                    height: 56,
                    backgroundColor: AppColors.blackColor,
                  )
                : CustomButton(
                    text: 'Confirm Details',
                    width: double.maxFinite,
                    height: 56,
                    fontSize: 16,
                    borderRadius: 16,
                    onTapHandler: handleSubmit,
                    fontWeight: FontWeight.w600,
                    fontColor: AppColors.whiteColor,
                    backgroundColor: isAddressValid.isFalse
                        ? AppColors.buttonPrimaryDisabledColor
                        : AppColors.buttonPrimaryColor,
                  ),
          );
        },
      ),
    );
  }
}
