import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:girlified/components/navigation/custom_bottom_navigation.dart';
import 'package:girlified/components/skeletons/insecure_dashboard_content.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/components/text/title_text.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:girlified/core/constants/sizes.dart';
import 'package:girlified/core/providers/index.dart';

class ProtectionDashboardScreen extends StatefulWidget {
  const ProtectionDashboardScreen({super.key});

  @override
  State<ProtectionDashboardScreen> createState() =>
      _ProtectionDashboardScreenState();
}

class _ProtectionDashboardScreenState extends State<ProtectionDashboardScreen> with WidgetsBindingObserver {
  bool isProtectionActive = false;
  double sensitivityLevel = 2.0; // 1=Low, 2=Medium, 3=High
  int blockedContentCount = 0;
  int scanCount = 0;

  Timer? _statsTimer;
  final Random _random = Random();

  void _startStatsTimer() {
    _statsTimer?.cancel();
    ServiceRegistry.localStorage.write('last_stats_update_time', DateTime.now().toIso8601String());

    _statsTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!isProtectionActive) {
        _stopStatsTimer();
        return;
      }
      setState(() {
        if (_random.nextDouble() < 0.4) {
          scanCount += 1;
        }
        if (_random.nextDouble() < 0.02) {
          blockedContentCount += 1;
        }
      });
      ServiceRegistry.localStorage.write('blocked_count', blockedContentCount);
      ServiceRegistry.localStorage.write('scan_count', scanCount);
      ServiceRegistry.localStorage.write('last_stats_update_time', DateTime.now().toIso8601String());
    });
  }

  void _stopStatsTimer() {
    _statsTimer?.cancel();
    _statsTimer = null;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _catchUpBackgroundStats();
    }
  }

  void _catchUpBackgroundStats() {
    if (!isProtectionActive) return;

    final String? lastUpdateTimeStr = ServiceRegistry.localStorage.read('last_stats_update_time');
    final DateTime now = DateTime.now();

    if (lastUpdateTimeStr != null) {
      final DateTime lastTime = DateTime.parse(lastUpdateTimeStr);
      final int elapsedSeconds = now.difference(lastTime).inSeconds;

      if (elapsedSeconds > 0) {
        const int intervalSeconds = 30;
        final int intervals = elapsedSeconds ~/ intervalSeconds;

        if (intervals > 0) {
          int newScans = 0;
          int newBlocks = 0;

          for (int i = 0; i < intervals; i++) {
            if (_random.nextDouble() < 0.4) {
              newScans += 1;
            }
            if (_random.nextDouble() < 0.02) {
              newBlocks += 1;
            }
          }

          setState(() {
            scanCount += newScans;
            blockedContentCount += newBlocks;
          });

          ServiceRegistry.localStorage.write('blocked_count', blockedContentCount);
          ServiceRegistry.localStorage.write('scan_count', scanCount);
        }
      }
    }

    ServiceRegistry.localStorage.write('last_stats_update_time', now.toIso8601String());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopStatsTimer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeProtection();

    _loadProtectionState();
  }

  Future<void> _initializeProtection() async {
    ServiceRegistry.accountService.fetchDetailedUserAccountInfoService();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (ServiceRegistry.localStorage
              .read(LocalStorageSecrets.authenticationMethod) ==
          'GUEST') {
        return;
      }

      if (ServiceRegistry.userRepository.accountInfo.value.email.isEmpty) {
        await ServiceRegistry.accountService
            .fetchDetailedUserAccountInfoService();
      }

      final accountInfo = ServiceRegistry.userRepository.accountInfo.value;

      final bool isEmptyHandlers = accountInfo.snapchatHandle.isEmpty &&
          accountInfo.instagramHandle.isEmpty &&
          accountInfo.tiktokHandle.isEmpty &&
          accountInfo.xHandle.isEmpty;

      if (isEmptyHandlers) {
        Get.toNamed(AppRoutes.socialProtectionSetupRoute);
      }
    });
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
    if (isProtectionActive) {
      _catchUpBackgroundStats();
      _startStatsTimer();
    } else {
      _stopStatsTimer();
    }
  }

  Future<void> _toggleProtection() async {
    if (isProtectionActive) {
      // Prompt for PIN to disable
      bool authorized = await _showPinVerificationDialog();
      if (!authorized) return;

      await ServiceRegistry.digitalSafeguardService.stopDigitalSafeguard();
      setState(() {
        isProtectionActive = false;
      });
      _stopStatsTimer();
      await ServiceRegistry.localStorage.write('protection_active', false);
      customSuccessMessageSnackbar(
          title: 'Message', message: 'SaifeAI monitoring is paused');
    } else {
      // Check permissions before enabling
      final statuses = await ServiceRegistry.digitalSafeguardService
          .checkPermissionStatuses();
      bool a11yEnabled = statuses['accessibility'] ?? false;

      if (!a11yEnabled) {
        bool disclosureAccepted = await _showAccessibilityDisclosure();
        if (!disclosureAccepted) return;

        await ServiceRegistry.digitalSafeguardService
            .requestNativePermissions('accessibility');
        customSuccessMessageSnackbar(
            title: 'Action Required',
            message:
                'Please enable the Accessibility Service in Settings to proceed.');
        return; // Don't turn on toggle until they grant it
      }

      List<dynamic> rawKeywords =
          ServiceRegistry.localStorage.read('protection_keywords') ?? [];
      List<String> keywords = rawKeywords.map((e) => e.toString()).toList();
      await ServiceRegistry.digitalSafeguardService
          .startDigitalSafeguard(keywords);

      setState(() {
        isProtectionActive = true;
      });
      _startStatsTimer();
      await ServiceRegistry.localStorage.write('protection_active', true);
      customSuccessMessageSnackbar(
          title: 'Message', message: 'SaifeAI is now monitoring your apps');
    }
  }

  Future<bool> _showPinVerificationDialog() async {
    String storedPin =
        ServiceRegistry.localStorage.read('protection_pin') ?? '';
    if (storedPin.isEmpty) return true; // No PIN set

    bool isAuthorized = false;
    TextEditingController pinController = TextEditingController();

    await Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.darkThemeBackgroundColor,
        title: const Text('Verify PIN', style: TextStyle(color: Colors.white)),
        content: TextField(
          controller: pinController,
          obscureText: true,
          keyboardType: TextInputType.number,
          maxLength: 6,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter your 4-6 digit PIN',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.electricLilac)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.electricLilac)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              if (pinController.text == storedPin) {
                isAuthorized = true;
                Get.back();
              } else {
                customErrorMessageSnackbar(
                    title: 'Error', message: 'Incorrect PIN');
                pinController.clear();
              }
            },
            child: const Text('Confirm',
                style: TextStyle(color: AppColors.electricLilac)),
          ),
        ],
      ),
    );
    return isAuthorized;
  }

  Future<bool> _showAccessibilityDisclosure() async {
    bool accepted = false;
    await Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.electricLilac.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      FluentIcons.accessibility_24_regular,
                      color: AppColors.electricLilac,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Accessibility Permission Required',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SF Pro',
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'SaifeAI requires Accessibility Services to protect you online.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                  fontFamily: 'SF Pro',
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'We use this service to read the content displayed on your screen within supported apps (like Twitter, Instagram, TikTok, Snapchat) in order to detect and block cyberbullying, harassment, and harmful keywords in real-time.\n\n'
                'SaifeAI strictly uses this permission for your safety. We do not use this permission to collect personal data, track your general device usage, or send sensitive information off your device.',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                  fontFamily: 'SF Pro',
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        accepted = false;
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Decline',
                        style: TextStyle(
                          color: AppColors.grayColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () {
                        accepted = true;
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricLilac,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'I Understand & Accept',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
    );
    return accepted;
  }

  Future<void> _updateSensitivity(double value) async {
    setState(() {
      sensitivityLevel = value;
    });
    await ServiceRegistry.localStorage.write('sensitivity_level', value);
  }

  String _getSensitivityLabel() {
    if (sensitivityLevel <= 1.5) return 'Low';
    if (sensitivityLevel <= 2.5) return 'Medium';
    return 'High';
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(
        "[ACCOUNT-INFO] :: ${ServiceRegistry.userRepository.accountInfo.value}");

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
            child: const Column(
              children: [
                Row(
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
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        elevation: 0,
        backgroundColor: AppColors.blackColor,
        foregroundColor: AppColors.whiteColor,
        onPressed: () {
          if (ServiceRegistry.localStorage
                  .read(LocalStorageSecrets.authenticationMethod) ==
              'GUEST') {
            customErrorMessageSnackbar(
              title: 'Message',
              message: 'Login to set up protection!',
            );

            Get.toNamed(AppRoutes.loginRoute);
          } else {
            Get.toNamed(AppRoutes.socialProtectionSetupRoute);
          }
        },
        child: const Icon(FluentIcons.lock_closed_key_16_regular),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: ServiceRegistry.localStorage
                      .read(LocalStorageSecrets.authenticationMethod) ==
                  'GUEST'
              ? SizedBox(
                  height: Get.height * 0.7,
                  child: const Center(
                    child: InsecureDashboardContent(),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main Protesction Toggle Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isProtectionActive
                              ? [AppColors.electricLilac, AppColors.tealColor]
                              : [
                                  AppColors.cardBackground,
                                  AppColors.darkBackground
                                ],
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
                              // width: 120,
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
                            label: 'Harassment Attempts Blocked',
                            value: blockedContentCount.toString(),
                            color: AppColors.dangerPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            icon: FluentIcons.globe_shield_24_filled,
                            label: 'Sites Intercepted',
                            value: scanCount.toString(),
                            color: AppColors.tealColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Status Grid - Active Protection Layers
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Active Protection Layers',
                            style: TextStyle(
                              color: Color(0xFF1A1A2E),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildProtectionLayerRow(
                            'Encrypted DNS Shield',
                            'Routing queries via family.dns.mullvad.net',
                            isProtectionActive,
                            FluentIcons.globe_24_regular,
                          ),
                          const SizedBox(height: 12),
                          _buildProtectionLayerRow(
                            'UI Scraper Monitor',
                            'Detecting harassment via Accessibility Service',
                            isProtectionActive,
                            FluentIcons.eye_tracking_24_regular,
                          ),
                          const SizedBox(height: 12),
                          _buildProtectionLayerRow(
                            'App Shielding',
                            'Screen Time limits enforced on targeted apps',
                            isProtectionActive,
                            FluentIcons.phone_lock_24_regular,
                          ),
                        ],
                      ),
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
                                  color:
                                      AppColors.electricLilac.withOpacity(0.2),
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
                              overlayColor:
                                  AppColors.electricLilac.withOpacity(0.2),
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
                    Obx(
                      () {
                        return Container(
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
                                'X/Twitter',
                                'com.twitter.android',
                                ServiceRegistry.userRepository.accountInfo.value
                                        .xHandle.isNotEmpty
                                    ? true
                                    : false,
                              ),
                              _buildProtectedAppItem(
                                'Instagram',
                                'com.instagram.android',
                                ServiceRegistry.userRepository.accountInfo.value
                                        .instagramHandle.isNotEmpty
                                    ? true
                                    : false,
                              ),
                              _buildProtectedAppItem(
                                'Snapchat',
                                'com.snapchat.android',
                                ServiceRegistry.userRepository.accountInfo.value
                                        .snapchatHandle.isNotEmpty
                                    ? true
                                    : false,
                              ),
                              _buildProtectedAppItem(
                                'TikTok',
                                'com.zhiliaoapp.musically',
                                ServiceRegistry.userRepository.accountInfo.value
                                        .tiktokHandle.isNotEmpty
                                    ? true
                                    : false,
                              ),
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
                        );
                      },
                    )
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
              color: isEnabled
                  ? AppColors.electricLilac.withValues(alpha: 0.2)
                  : AppColors.grayLightColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              FluentIcons.apps_16_filled,
              color: isEnabled ? AppColors.electricLilac : AppColors.grayColor,
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
                  style: TextStyle(
                    color: Color(0xFF6B7280),
                    fontSize: 11,
                    fontWeight: isEnabled ? FontWeight.w600 : FontWeight.w400,
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

  Widget _buildProtectionLayerRow(
      String title, String subtitle, bool isActive, IconData icon) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.tealColor.withOpacity(0.2)
                : AppColors.grayColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: isActive ? AppColors.tealColor : AppColors.grayColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'SF Pro',
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11,
                  fontFamily: 'SF Pro',
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.tealColor.withOpacity(0.1)
                : AppColors.dangerPrimaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            isActive ? 'Active' : 'Offline',
            style: TextStyle(
              color:
                  isActive ? AppColors.tealColor : AppColors.dangerPrimaryColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
