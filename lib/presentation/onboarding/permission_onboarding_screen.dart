import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:girlified/core/constants/routes.dart';

class PermissionOnboardingScreen extends StatefulWidget {
  const PermissionOnboardingScreen({super.key});

  @override
  State<PermissionOnboardingScreen> createState() =>
      _PermissionOnboardingScreenState();
}

class _PermissionOnboardingScreenState
    extends State<PermissionOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      icon: FluentIcons.shield_checkmark_48_filled,
      title: 'Welcome to SaifeAI',
      description:
          'Your digital bodyguard that protects you from harmful content on social media.',
      color: AppColors.electricLilac,
    ),
    OnboardingPage(
      icon: FluentIcons.eye_48_filled,
      title: 'Real-Time Protection',
      description:
          'SaifeAI monitors TikTok, Instagram, and YouTube in real-time to detect and block harmful content before you see it.',
      color: AppColors.tealColor,
    ),
    OnboardingPage(
      icon: FluentIcons.lock_closed_48_filled,
      title: 'Privacy First',
      description:
          'All content analysis happens on your device using AI. No screenshots or data ever leave your phone.',
      color: AppColors.electricLilac,
    ),
    OnboardingPage(
      icon: FluentIcons.settings_48_filled,
      title: 'Permissions Required',
      description:
          'To protect you, SaifeAI needs special permissions. Let\'s set them up together.',
      color: AppColors.tealColor,
      isPermissionPage: true,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showPermissionsSetup();
    }
  }

  void _skipToPermissions() {
    _pageController.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _showPermissionsSetup() async {
    await Get.bottomSheet(
      const PermissionsSetupSheet(),
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            if (_currentPage < _pages.length - 1)
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: _skipToPermissions,
                  child: const Text(
                    'Skip',
                    style: TextStyle(
                      color: AppColors.textTertiaryInverseColor,
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                ),
              ),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(_pages[index]);
                },
              ),
            ),

            // Page indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => _buildPageIndicator(index == _currentPage),
              ),
            ),
            const SizedBox(height: 32),

            // Next button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: _nextPage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.electricLilac,
                  foregroundColor: AppColors.whiteColor,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(double.infinity, 56),
                ),
                child: Text(
                  _currentPage == _pages.length - 1
                      ? 'Set Up Permissions'
                      : 'Continue',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 64,
              color: page.color,
            ),
          )
              .animate()
              .scale(duration: 600.ms, curve: Curves.easeOut)
              .fadeIn(duration: 400.ms),
          const SizedBox(height: 48),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.whiteColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          )
              .animate()
              .fadeIn(delay: 200.ms, duration: 400.ms)
              .slideY(begin: 0.3, end: 0),
          const SizedBox(height: 16),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textTertiaryInverseColor,
              fontSize: 16,
              height: 1.5,
              fontFamily: 'SF Pro',
            ),
          )
              .animate()
              .fadeIn(delay: 400.ms, duration: 400.ms)
              .slideY(begin: 0.3, end: 0),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(bool isActive) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.electricLilac : AppColors.grayColor,
        borderRadius: BorderRadius.circular(4),
      ),
    ).animate().scale(duration: 200.ms);
  }
}

class OnboardingPage {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isPermissionPage;

  OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isPermissionPage = false,
  });
}

class PermissionsSetupSheet extends StatefulWidget {
  const PermissionsSetupSheet({super.key});

  @override
  State<PermissionsSetupSheet> createState() => _PermissionsSetupSheetState();
}

class _PermissionsSetupSheetState extends State<PermissionsSetupSheet> {
  bool _accessibilityGranted = false;
  bool _overlayGranted = false;
  bool _notificationsGranted = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    // Check notification permission
    final notificationStatus = await Permission.notification.status;

    setState(() {
      _notificationsGranted = notificationStatus.isGranted;
      // Accessibility and overlay need to be checked via platform channels
      // For now, we'll assume they're not granted
      _accessibilityGranted = false;
      _overlayGranted = false;
    });
  }

  Future<void> _requestNotificationPermission() async {
    final status = await Permission.notification.request();
    setState(() {
      _notificationsGranted = status.isGranted;
    });
  }

  Future<void> _openAccessibilitySettings() async {
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

    // Simulate permission granted for demo
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      _accessibilityGranted = true;
    });
  }

  Future<void> _requestOverlayPermission() async {
    final status = await Permission.systemAlertWindow.request();
    setState(() {
      _overlayGranted = status.isGranted;
    });
  }

  bool get _allPermissionsGranted =>
      _accessibilityGranted && _overlayGranted && _notificationsGranted;

  void _completeOnboarding() {
    // Save onboarding completion
    Get.offAllNamed(AppRoutes.dashboardRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grayColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Required Permissions',
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'SaifeAI needs these permissions to protect you',
            style: TextStyle(
              color: AppColors.textTertiaryInverseColor,
              fontSize: 14,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPermissionCard(
                    icon: FluentIcons.accessibility_checkmark_24_filled,
                    title: 'Accessibility Service',
                    description:
                        'Allows SaifeAI to read screen content in real-time to detect harmful material',
                    isGranted: _accessibilityGranted,
                    onTap: _openAccessibilitySettings,
                  ),
                  const SizedBox(height: 16),
                  _buildPermissionCard(
                    icon: FluentIcons.window_shield_24_filled,
                    title: 'Display Over Other Apps',
                    description:
                        'Enables the blur overlay to protect you when harmful content is detected',
                    isGranted: _overlayGranted,
                    onTap: _requestOverlayPermission,
                  ),
                  const SizedBox(height: 16),
                  _buildPermissionCard(
                    icon: FluentIcons.alert_24_filled,
                    title: 'Notifications',
                    description: 'Get alerts when harmful content is blocked',
                    isGranted: _notificationsGranted,
                    onTap: _requestNotificationPermission,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _allPermissionsGranted ? _completeOnboarding : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.electricLilac,
              foregroundColor: AppColors.whiteColor,
              disabledBackgroundColor: AppColors.grayColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 56),
            ),
            child: Text(
              _allPermissionsGranted
                  ? 'Get Started'
                  : 'Complete All Permissions',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'SF Pro',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionCard({
    required IconData icon,
    required String title,
    required String description,
    required bool isGranted,
    required VoidCallback onTap,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isGranted
              ? AppColors.tealColor.withOpacity(0.5)
              : AppColors.grayColor.withOpacity(0.3),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: (isGranted
                          ? AppColors.tealColor
                          : AppColors.electricLilac)
                      .withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color:
                      isGranted ? AppColors.tealColor : AppColors.electricLilac,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.whiteColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'SF Pro',
                  ),
                ),
              ),
              if (isGranted)
                const Icon(
                  FluentIcons.checkmark_circle_20_filled,
                  color: AppColors.tealColor,
                  size: 24,
                ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(
              color: AppColors.textTertiaryInverseColor,
              fontSize: 13,
              fontFamily: 'SF Pro',
            ),
          ),
          if (!isGranted) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.electricLilac,
                foregroundColor: AppColors.whiteColor,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 44),
              ),
              child: const Text(
                'Grant Permission',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
