import 'dart:developer';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/buttons/custom_back_button.dart';
import 'package:girlified/components/images/cached_network_image_widget.dart';
import 'package:girlified/components/modals/update_profile_avatar_bottom_modal.dart';

class ProfileAppBar extends StatelessWidget {
  const ProfileAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        padding: const EdgeInsets.only(
          top: AppSizes.vertical_10,
          left: AppSizes.horizontal_15,
          right: AppSizes.horizontal_15,
        ),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: AppSizes.horizontal_35),
                  // CustomBackButton(
                  //   callBackFunction: () {
                  //     Get.until((route) =>
                  //         route.settings.name == AppRoutes.dashboardRoute);
                  //   },
                  // ),
                  TitleText(
                    size: 16,
                    title: 'Account',
                  ),
                  const SizedBox(width: AppSizes.horizontal_35),
                ],
              ),
              const SizedBox(height: AppSizes.vertical_8),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        log('[OPEN-UPDATE-PROFILE-AVATAR-MODAL]');

                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return const UpdateProfileAvatarBottomModal();
                          },
                        );
                      },
                      overlayColor: const WidgetStatePropertyAll(
                        Colors.transparent,
                      ),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 2,
                            color: AppColors.grayLightColor,
                          ),
                        ),
                        child: ClipOval(
                          child: CachedNetworkImageWidget(
                            height: double.maxFinite,
                            width: double.maxFinite,
                            imageUrl: ServiceRegistry
                                .userRepository.accountInfo.value.profilePhoto,
                            errorAssetImage: 'assets/images/default.jpg',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(),
                    // const CustomSupportButton(),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.vertical_8),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleText(
                          size: 18,
                          // title: '',
                          title:
                              '${ServiceRegistry.userRepository.accountInfo.value.firstName} ${ServiceRegistry.userRepository.accountInfo.value.lastName}',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
