import 'package:flutter/material.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/components/text/body_text.dart';
import 'package:girlified/components/appbar/default_appbar.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool showBorder = true,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSizes.vertical_12),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.blackColor,
                  size: 24,
                ),
                const SizedBox(width: AppSizes.horizontal_12),
                Expanded(
                  child: BodyText(
                    text: title,
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: AppColors.contentTertiaryColor,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
        if (showBorder)
          Divider(
            color: AppColors.grayLightColor,
            height: 1,
          ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    bool showBorder = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSizes.vertical_12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BodyText(
                      text: title,
                      size: 16,
                      weight: FontWeight.w500,
                    ),
                    const SizedBox(height: 4),
                    BodyText(
                      text: subtitle,
                      color: AppColors.contentTertiaryColor,
                    ),
                  ],
                ),
              ),
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.orangeColor,
              ),
            ],
          ),
        ),
        if (showBorder)
          Divider(
            color: AppColors.grayLightColor,
            height: 1,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppbar(
          title: 'Profile',
          showBackButton: false,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontal_10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  // Profile Image
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person_outline,
                        color: AppColors.orangeColor,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSizes.horizontal_10),

                  // User Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TitleText(
                              title: 'Sarah Mitchell',
                              size: 20,
                              weight: FontWeight.w600,
                            ),
                            Icon(
                              Icons.edit,
                              color: AppColors.contentTertiaryColor,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        BodyText(
                          text: 'sarah.mitchell@email.com',
                          color: AppColors.contentTertiaryColor,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.horizontal_12,
                            vertical: AppSizes.vertical_4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orangeColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: BodyText(
                            text: 'Premium Member',
                            color: AppColors.orangeColor,
                            size: 12,
                            weight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // Health Summary Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: AppColors.orangeColor,
                        size: 24,
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: 'Health Summary',
                        size: 20,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Stats Grid
                  Row(
                    children: [
                      // Tests Completed
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppSizes.horizontal_16),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '127',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.orangeColor,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              BodyText(
                                text: 'Tests completed',
                                color: AppColors.contentTertiaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSizes.horizontal_16),
                      // Health Score
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(AppSizes.horizontal_16),
                          decoration: BoxDecoration(
                            color: AppColors.backgroundSecondaryColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '96%',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.greenColor,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 4),
                              BodyText(
                                text: 'Health score',
                                color: AppColors.contentTertiaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_20),

                  // Additional Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyText(
                        text: 'Average cycle length',
                        color: AppColors.contentTertiaryColor,
                      ),
                      BodyText(
                        text: '28 days',
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.vertical_16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BodyText(
                        text: 'Last test',
                        color: AppColors.contentTertiaryColor,
                      ),
                      BodyText(
                        text: '2 hours ago',
                        weight: FontWeight.w500,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // Account Settings Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: AppColors.orangeColor,
                        size: 16,
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: 'Account Settings',
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Settings List
                  _buildSettingsItem(
                    icon: Icons.person_outline,
                    title: 'Personal Information',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.calendar_today,
                    title: 'Cycle Settings',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.favorite_border,
                    title: 'Health Preferences',
                    onTap: () {},
                    showBorder: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // Notifications Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.notifications_none,
                        color: AppColors.orangeColor,
                        size: 18,
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: 'Notifications',
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Notification Settings
                  _buildNotificationItem(
                    title: 'Period Reminders',
                    subtitle: 'Get notified before your period',
                    value: true,
                    onChanged: (value) {},
                  ),
                  _buildNotificationItem(
                    title: 'Test Reminders',
                    subtitle: 'Regular testing schedule alerts',
                    value: true,
                    onChanged: (value) {},
                  ),
                  _buildNotificationItem(
                    title: 'Health Insights',
                    subtitle: 'Weekly health summaries',
                    value: false,
                    onChanged: (value) {},
                  ),
                  _buildNotificationItem(
                    title: 'Ovulation Alerts',
                    subtitle: 'Fertility window notifications',
                    value: true,
                    onChanged: (value) {},
                    showBorder: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // Data & Privacy Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.shield_outlined,
                        color: AppColors.orangeColor,
                        size: 16,
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: 'Data & Privacy',
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Privacy List
                  _buildSettingsItem(
                    icon: Icons.download,
                    title: 'Export My Data',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.description_outlined,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.security,
                    title: 'Data Security',
                    onTap: () {},
                    showBorder: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // Support & Help Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    children: [
                      Icon(
                        Icons.help_outline,
                        color: AppColors.orangeColor,
                        size: 16,
                      ),
                      const SizedBox(width: AppSizes.horizontal_8),
                      TitleText(
                        title: 'Support & Help',
                        size: 16,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSizes.vertical_16),

                  // Support List
                  _buildSettingsItem(
                    icon: Icons.help,
                    title: 'Help Center',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.mail_outline,
                    title: 'Contact Support',
                    onTap: () {},
                  ),
                  _buildSettingsItem(
                    icon: Icons.phone,
                    title: 'Emergency Hotline',
                    onTap: () {},
                    showBorder: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // App Info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSizes.horizontal_20),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.grayLightColor,
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  BodyText(
                    text: 'Girlified App Version 1.1.2',
                    color: AppColors.contentTertiaryColor,
                    alignment: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSizes.vertical_10),

            // Sign Out Button
            InkWell(
              onTap: () {
                // TODO: Implement sign out
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSizes.horizontal_16),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.redColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.redColor,
                      size: 20,
                    ),
                    const SizedBox(width: AppSizes.horizontal_8),
                    BodyText(
                      text: 'Sign Out',
                      color: AppColors.redColor,
                      weight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppSizes.vertical_20),
          ],
        ),
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
