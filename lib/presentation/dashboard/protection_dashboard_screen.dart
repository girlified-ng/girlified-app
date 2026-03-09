import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';

class ProtectionDashboardScreen extends StatefulWidget {
  const ProtectionDashboardScreen({super.key});

  @override
  State<ProtectionDashboardScreen> createState() =>
      _ProtectionDashboardScreenState();
}

class _ProtectionDashboardScreenState extends State<ProtectionDashboardScreen> {
  bool isProtectionActive = false;
  double sensitivityLevel = 2.0; // 1=Low, 2=Medium, 3=High
  int blockedContentCount = 0;
  int scanCount = 0;

  @override
  void initState() {
    super.initState();
    _loadProtectionState();
  }

  Future<void> _loadProtectionState() async {
    // TODO: Load from SharedPreferences or local storage
    setState(() {
      isProtectionActive =
          ServiceRegistry.localStorage.read('protection_active') ?? false;
      sensitivityLevel =
          ServiceRegistry.localStorage.read('sensitivity_level') ?? 2.0;
      blockedContentCount =
          ServiceRegistry.localStorage.read('blocked_count') ?? 0;
      scanCount = ServiceRegistry.localStorage.read('scan_count') ?? 0;
    });
  }

  Future<void> _toggleProtection() async {
    setState(() {
      isProtectionActive = !isProtectionActive;
    });
    await ServiceRegistry.localStorage
        .write('protection_active', isProtectionActive);

    if (isProtectionActive) {
      // TODO: Start accessibility service
      _showSnackbar(
          'Protection Activated', 'Girlified is now monitoring your apps');
    } else {
      // TODO: Stop accessibility service
      _showSnackbar('Protection Paused', 'Girlified monitoring is paused');
    }
  }

  Future<void> _updateSensitivity(double value) async {
    setState(() {
      sensitivityLevel = value;
    });
    await ServiceRegistry.localStorage.write('sensitivity_level', value);
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      backgroundColor: AppColors.darkThemeAppBarBackgroundColor,
      colorText: AppColors.whiteColor,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
    );
  }

  String _getSensitivityLabel() {
    if (sensitivityLevel <= 1.5) return 'Low';
    if (sensitivityLevel <= 2.5) return 'Medium';
    return 'High';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: SafeArea(
          child: Container(
            // color: Colors.amber,
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(
              // top: AppSizes.vertical_5,
              horizontal: AppSizes.horizontal_15,
            ),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: AppSizes.horizontal_35),
                    TitleText(
                      size: 16,
                      title: 'Protection',
                    ),
                    SizedBox(width: AppSizes.horizontal_35),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Protection Toggle Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: isProtectionActive
                        ? [AppColors.electricLilac, AppColors.tealColor]
                        : [AppColors.cardBackground, AppColors.darkBackground],
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: isProtectionActive
                          ? AppColors.electricLilac.withOpacity(0.3)
                          : Colors.black26,
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Protection Icon with Pulse Animation
                    GestureDetector(
                      key: ValueKey(isProtectionActive),
                      onTap: _toggleProtection,
                      child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            isProtectionActive
                                ? FluentIcons.shield_checkmark_48_filled
                                : FluentIcons.shield_48_regular,
                            size: 64,
                            color: AppColors.whiteColor,
                          ),
                        ),
                      )
                          .animate(
                            autoPlay: false,
                            onPlay: (controller) {
                              if (isProtectionActive) controller.repeat();
                            },
                          )
                          .shimmer(
                            duration: isProtectionActive ? 2000.ms : 0.ms,
                            color: Colors.white.withOpacity(0.3),
                          )
                          .scale(
                            duration: isProtectionActive ? 1500.ms : 0.ms,
                            begin: const Offset(1.0, 1.0),
                            end: const Offset(1.05, 1.05),
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      isProtectionActive
                          ? 'Protection Active'
                          : 'Protection Paused',
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      isProtectionActive
                          ? 'Your digital bodyguard is watching'
                          : 'Tap the shield to activate protection',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.whiteColor.withOpacity(0.8),
                        fontSize: 14,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Toggle Button
                    ElevatedButton(
                      onPressed: _toggleProtection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.whiteColor,
                        foregroundColor: isProtectionActive
                            ? AppColors.electricLilac
                            : AppColors.grayColor,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isProtectionActive
                                ? FluentIcons.pause_16_filled
                                : FluentIcons.play_16_filled,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            isProtectionActive
                                ? 'Pause Protection'
                                : 'Activate Protection',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: FluentIcons.shield_error_24_filled,
                      label: 'Content Blocked',
                      value: blockedContentCount.toString(),
                      color: AppColors.dangerPrimaryColor,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      icon: FluentIcons.scan_24_filled,
                      label: 'Items Scanned',
                      value: scanCount.toString(),
                      color: AppColors.tealColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Sensitivity Control
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Safety Sensitivity',
                          style: TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.electricLilac.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            _getSensitivityLabel(),
                            style: const TextStyle(
                              color: AppColors.electricLilac,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SliderTheme(
                      data: SliderThemeData(
                        activeTrackColor: AppColors.electricLilac,
                        inactiveTrackColor:
                            AppColors.grayColor.withOpacity(0.3),
                        thumbColor: AppColors.electricLilac,
                        overlayColor: AppColors.electricLilac.withOpacity(0.2),
                        thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 12,
                        ),
                        trackHeight: 4,
                      ),
                      child: Slider(
                        value: sensitivityLevel,
                        min: 1.0,
                        max: 3.0,
                        divisions: 2,
                        onChanged: _updateSensitivity,
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Low',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        Text(
                          'Medium',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                        Text(
                          'High',
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 12,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _getSensitivityDescription(),
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 13,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Protected Apps Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Protected Apps',
                      style: TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProtectedAppItem(
                        'TikTok', 'com.zhiliaoapp.musically', true),
                    _buildProtectedAppItem(
                        'Instagram', 'com.instagram.android', true),
                    _buildProtectedAppItem(
                        'YouTube', 'com.google.android.youtube', true),
                    const SizedBox(height: 12),
                    // TextButton.icon(
                    //   onPressed: () {
                    //     // TODO: Navigate to app selection
                    //   },
                    //   icon: const Icon(
                    //     FluentIcons.add_circle_16_regular,
                    //     size: 18,
                    //   ),
                    //   label: const Text('Add More Apps'),
                    //   style: TextButton.styleFrom(
                    //     foregroundColor: AppColors.electricLilac,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
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

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF1A1A2E),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF6B7280),
              fontSize: 12,
              fontFamily: 'SF Pro',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtectedAppItem(
      String appName, String packageName, bool isEnabled) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.electricLilac.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              FluentIcons.apps_16_filled,
              color: AppColors.electricLilac,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appName,
                  style: const TextStyle(
                    color: Color(0xFF1A1A2E),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'SF Pro',
                  ),
                ),
                Text(
                  packageName,
                  style: const TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isEnabled
                ? FluentIcons.checkmark_circle_20_filled
                : FluentIcons.circle_20_regular,
            color: isEnabled ? AppColors.tealColor : AppColors.grayColor,
            size: 20,
          ),
        ],
      ),
    );
  }

  String _getSensitivityDescription() {
    if (sensitivityLevel <= 1.5) {
      return 'Only blocks extremely violent or explicit content';
    } else if (sensitivityLevel <= 2.5) {
      return 'Blocks moderately harmful content including violence and harassment';
    } else {
      return 'Maximum protection - blocks all potentially harmful content';
    }
  }
}
