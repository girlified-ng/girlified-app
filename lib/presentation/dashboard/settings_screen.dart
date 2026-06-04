import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool hapticFeedbackEnabled = true;
  bool darkModeEnabled = true; 
  bool autoBlockEnabled = true;
  String appVersion = '1.0.0';

  @override
  void initState() {
    super.initState();
    _loadSettings();
    _loadAppVersion();
  }

  Future<void> _loadSettings() async {
    // TODO: Load from SharedPreferences
    setState(() {
      notificationsEnabled = true;
      hapticFeedbackEnabled = true;
      darkModeEnabled = true;
      autoBlockEnabled = true;
    });
  }

  Future<void> _loadAppVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  Future<void> _checkAndRequestPermissions() async {
    final accessibilityStatus = PermissionStatus.denied;

    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  FluentIcons.shield_checkmark_48_filled,
                  color: AppColors.electricLilac,
                  size: 64,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Required Permissions',
                  style: TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SF Pro',
                  ),
                ),
                const SizedBox(height: 16),
                _buildPermissionItem(
                  'Accessibility Service',
                  'Allows SaifeAI to monitor app content in real-time',
                  accessibilityStatus.isGranted,
                ),
                _buildPermissionItem(
                  'Display Over Other Apps',
                  'Enables blur overlay protection when harmful content is detected',
                  false, // Will be checked via native code
                ),
                _buildPermissionItem(
                  'Notifications',
                  'Get alerts when harmful content is blocked',
                  notificationsEnabled,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                    _openAccessibilitySettings();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.electricLilac,
                    foregroundColor: AppColors.whiteColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Open Settings',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openAccessibilitySettings() {
    // TODO: Open accessibility settings via platform channel
    Get.snackbar(
      'Opening Settings',
      'Please enable SaifeAI in Accessibility Services',
      backgroundColor: AppColors.darkThemeAppBarBackgroundColor,
      colorText: AppColors.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.darkThemeBackgroundColor,
        elevation: 0,
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Profile Section (if authenticated)
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.electricLilac, AppColors.tealColor],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FluentIcons.person_48_filled,
                      color: AppColors.whiteColor,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Protected User',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Your digital bodyguard is active',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 13,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    FluentIcons.chevron_right_16_filled,
                    color: AppColors.whiteColor,
                  ),
                ],
              ),
            ),

            // Permissions Section
            _buildSectionHeader('Permissions'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.shield_checkmark_20_filled,
                title: 'Accessibility Service',
                subtitle: 'Required for real-time protection',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: _checkAndRequestPermissions,
              ),
              _buildSettingsTile(
                icon: FluentIcons.window_shield_20_filled,
                title: 'Display Over Apps',
                subtitle: 'Enable blur overlay protection',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: _checkAndRequestPermissions,
              ),
            ]),

            // Protection Settings
            _buildSectionHeader('Protection'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.shield_error_20_filled,
                title: 'Auto-Block Content',
                subtitle: 'Automatically hide harmful content',
                trailing: Switch(
                  value: autoBlockEnabled,
                  onChanged: (value) {
                    setState(() {
                      autoBlockEnabled = value;
                    });
                    // TODO: Save to preferences
                  },
                  activeColor: AppColors.electricLilac,
                ),
              ),
              _buildSettingsTile(
                icon: FluentIcons.apps_20_filled,
                title: 'Protected Apps',
                subtitle: 'Manage which apps to monitor',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  // TODO: Navigate to app selection
                },
              ),
              _buildSettingsTile(
                icon: FluentIcons.warning_20_filled,
                title: 'Content Categories',
                subtitle: 'Choose what types of content to block',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  _showContentCategoriesSheet();
                },
              ),
            ]),

            // Notifications
            _buildSectionHeader('Notifications'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.alert_20_filled,
                title: 'Push Notifications',
                subtitle: 'Get alerts about blocked content',
                trailing: Switch(
                  value: notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      notificationsEnabled = value;
                    });
                    // TODO: Save to preferences
                  },
                  activeColor: AppColors.electricLilac,
                ),
              ),
              _buildSettingsTile(
                icon: FluentIcons.phone_vibrate_20_filled,
                title: 'Haptic Feedback',
                subtitle: 'Vibrate when content is blocked',
                trailing: Switch(
                  value: hapticFeedbackEnabled,
                  onChanged: (value) {
                    setState(() {
                      hapticFeedbackEnabled = value;
                    });
                    // TODO: Save to preferences
                  },
                  activeColor: AppColors.electricLilac,
                ),
              ),
            ]),

            // Appearance
            _buildSectionHeader('Appearance'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.dark_theme_20_filled,
                title: 'Dark Mode',
                subtitle: 'Always use dark theme',
                trailing: Switch(
                  value: darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      darkModeEnabled = value;
                    });
                    // TODO: Toggle theme
                  },
                  activeColor: AppColors.electricLilac,
                ),
              ),
            ]),

            // Privacy & Data
            _buildSectionHeader('Privacy & Data'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.lock_closed_20_filled,
                title: 'Privacy Policy',
                subtitle: 'How we protect your data',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  // TODO: Open privacy policy
                },
              ),
              _buildSettingsTile(
                icon: FluentIcons.database_20_filled,
                title: 'Data Usage',
                subtitle: 'All processing happens on-device',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  _showDataUsageInfo();
                },
              ),
              _buildSettingsTile(
                icon: FluentIcons.delete_20_filled,
                title: 'Clear History',
                subtitle: 'Delete all blocked content records',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  _showClearHistoryConfirmation();
                },
              ),
            ]),

            // Support
            _buildSectionHeader('Support'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.question_circle_20_filled,
                title: 'Help Center',
                subtitle: 'Get help and FAQs',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  // TODO: Open help center
                },
              ),
              _buildSettingsTile(
                icon: FluentIcons.mail_20_filled,
                title: 'Contact Support',
                subtitle: 'support@girlified.com.ng',
                trailing: const Icon(
                  FluentIcons.chevron_right_16_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  // TODO: Open email
                },
              ),
            ]),

            // About
            _buildSectionHeader('About'),
            _buildSettingsCard([
              _buildSettingsTile(
                icon: FluentIcons.info_20_filled,
                title: 'App Version',
                subtitle: 'Version $appVersion',
              ),
              _buildSettingsTile(
                icon: FluentIcons.globe_20_filled,
                title: 'Website',
                subtitle: 'saifeai.girlified.com.ng',
                trailing: const Icon(
                  FluentIcons.open_20_filled,
                  color: AppColors.textTertiaryInverseColor,
                ),
                onTap: () {
                  // TODO: Open website
                },
              ),
            ]),

            const SizedBox(height: 40),
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

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: AppColors.textTertiaryInverseColor,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          fontFamily: 'SF Pro',
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.electricLilac.withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.electricLilac, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 15,
          fontWeight: FontWeight.w500,
          fontFamily: 'SF Pro',
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: TextStyle(
                color: AppColors.textTertiaryInverseColor,
                fontSize: 13,
                fontFamily: 'SF Pro',
              ),
            )
          : null,
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildPermissionItem(
      String title, String description, bool isGranted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isGranted
                ? FluentIcons.checkmark_circle_20_filled
                : FluentIcons.warning_20_filled,
            color: isGranted ? AppColors.tealColor : AppColors.orangeColor,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: TextStyle(
                    color: AppColors.textTertiaryInverseColor,
                    fontSize: 12,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showContentCategoriesSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Content Categories',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'SF Pro',
              ),
            ),
            const SizedBox(height: 20),
            _buildCategoryCheckbox('Violence & Gore', true),
            _buildCategoryCheckbox('Sexual Content', true),
            _buildCategoryCheckbox('Harassment & Bullying', true),
            _buildCategoryCheckbox('Hate Speech', true),
            _buildCategoryCheckbox('Self-Harm', true),
            _buildCategoryCheckbox('Dangerous Activities', false),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCheckbox(String label, bool value) {
    return CheckboxListTile(
      value: value,
      onChanged: (newValue) {
        // TODO: Update category
      },
      title: Text(
        label,
        style: const TextStyle(
          color: AppColors.whiteColor,
          fontSize: 15,
          fontFamily: 'SF Pro',
        ),
      ),
      activeColor: AppColors.electricLilac,
      checkColor: AppColors.whiteColor,
    );
  }

  void _showDataUsageInfo() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(FluentIcons.lock_closed_20_filled,
                color: AppColors.electricLilac),
            SizedBox(width: 12),
            Text(
              'Privacy First',
              style: TextStyle(
                color: AppColors.whiteColor,
                fontFamily: 'SF Pro',
              ),
            ),
          ],
        ),
        content: const Text(
          'SaifeAI processes all content analysis on your device using TensorFlow Lite. '
          'No screenshots or data are ever sent to our servers. Your privacy is our priority.',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14,
            fontFamily: 'SF Pro',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Got It',
              style: TextStyle(
                color: AppColors.electricLilac,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showClearHistoryConfirmation() {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Clear History?',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontFamily: 'SF Pro',
          ),
        ),
        content: const Text(
          'This will permanently delete all records of blocked content. This action cannot be undone.',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 14,
            fontFamily: 'SF Pro',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: AppColors.textTertiaryInverseColor,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // TODO: Clear history
              Get.snackbar(
                'History Cleared',
                'All blocked content records have been deleted',
                backgroundColor: AppColors.darkThemeAppBarBackgroundColor,
                colorText: AppColors.whiteColor,
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text(
              'Clear',
              style: TextStyle(
                color: AppColors.dangerPrimaryColor,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
