import 'package:flutter/material.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/components/skeletons/insecure_dashboard_content.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/utilities/index.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/components/appbar/profile_appbar.dart';
import 'package:girlified/components/buttons/logout_button.dart';
import 'package:girlified/components/cards/profile_menu_item_card.dart';
import 'package:girlified/components/buttons/delete_account_button.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();

    ServiceRegistry.accountService.fetchDetailedUserAccountInfoService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          ServiceRegistry.localStorage
                      .read(LocalStorageSecrets.authenticationMethod) ==
                  'GUEST'
              ? 0
              : 135,
        ),
        child: const ProfileAppBar(),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontal_15,
                ),
                child: ServiceRegistry.localStorage
                            .read(LocalStorageSecrets.authenticationMethod) ==
                        'GUEST'
                    ? SizedBox(
                        height: AppSizes.screenHeight(context) * 0.7,
                        child: const Center(
                          child: InsecureDashboardContent(),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: AppSizes.vertical_10),
                          const SizedBox(height: AppSizes.vertical_10),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: profileMenuItems.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return ProfileMenuItemCard(
                                hasTopBorder: index != 0,
                                item: profileMenuItems[index],
                              );
                            },
                          ),
                          Divider(
                              color: AppColors.grayLightColor.withOpacity(0.6)),
                          const LogoutButton(),
                          const DeleteAccountButton(),
                          const SizedBox(height: AppSizes.vertical_50),
                        ],
                      ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: (int value) {
          ServiceRegistry.commonRepository.currentScreenIndex.value = value;
        },
        currentPage: ServiceRegistry.commonRepository.currentScreenIndex.value,
      ),
    );
  }
}
