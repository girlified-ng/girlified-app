import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';

class SocialProtectionSetupScreen extends StatefulWidget {
  const SocialProtectionSetupScreen({super.key});

  @override
  State<SocialProtectionSetupScreen> createState() =>
      _SocialProtectionSetupScreenState();
}

class _SocialProtectionSetupScreenState
    extends State<SocialProtectionSetupScreen> {
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController snapchatController = TextEditingController();

  bool isProtecting = false;
  String processingStatus = '';

  Future<void> _handleProtect() async {
    setState(() {
      isProtecting = true;
    });

    if (twitterController.text.isEmpty &&
        instagramController.text.isEmpty &&
        tiktokController.text.isEmpty &&
        snapchatController.text.isEmpty) {
      setState(() {
        isProtecting = false;
      });
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }

    // [SAVING ALL THE SOCIAL MEDIA HANDLERS INTO LOCAL STORAGE]
    await ServiceRegistry.localStorage.write('twitter', twitterController.text);
    await ServiceRegistry.localStorage.write('instagram', instagramController.text);
    await ServiceRegistry.localStorage.write('tiktok', tiktokController.text);
    await ServiceRegistry.localStorage.write('snapchat', snapchatController.text);

    // Simulate AI Protection Sequence
    final steps = [
      'Connecting to Social Accounts...',
      'Scanning for threats...',
      'Analyzing content patterns...',
      'Activating Saife Neural Shield...',
      'Protection Enabled!',
    ];

    for (var step in steps) {
      if (!mounted) return;
      setState(() {
        processingStatus = step;
      });
      await Future.delayed(const Duration(milliseconds: 1500));
    }

    await ServiceRegistry.localStorage.write('protection_active', true);
    await ServiceRegistry.localStorage
        .write('blocked_count', 12); // Fake start data
    await ServiceRegistry.localStorage.write('scan_count', 1450);

    if (!mounted) return;
    Get.offAllNamed(AppRoutes.dashboardRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackgroundColor,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Protect Your\nDigital Self',
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro',
                      height: 1.2,
                    ),
                  ).animate().fadeIn().slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 16),
                  Text(
                    'Connect your accounts to enable real-time threat protection.',
                    style: TextStyle(
                      color: AppColors.whiteColor.withOpacity(0.7),
                      fontSize: 16,
                      fontFamily: 'SF Pro',
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 40),

                  // Input Fields
                  _buildInput(
                    'Twitter / X',
                    FluentIcons.mention_24_regular,
                    twitterController,
                    delay: 400,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    'Instagram',
                    FluentIcons.camera_24_regular,
                    instagramController,
                    delay: 500,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    'TikTok',
                    FluentIcons.video_24_regular,
                    tiktokController,
                    delay: 600,
                  ),
                  const SizedBox(height: 16),
                  _buildInput(
                    'Snapchat',
                    FluentIcons.chat_24_regular,
                    snapchatController,
                    delay: 700,
                  ),

                  const SizedBox(height: 40),

                  // Protect Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _handleProtect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.electricLilac,
                        foregroundColor: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 8,
                        shadowColor: AppColors.electricLilac.withOpacity(0.5),
                      ),
                      child: const Text(
                        'Activate Protection',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'SF Pro',
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 900.ms)
                      .slideY(begin: 0.5, end: 0)
                      .shimmer(delay: 1500.ms, duration: 1800.ms),
                ],
              ),
            ),
          ),

          // Processing Overlay
          if (isProtecting)
            Container(
              color: Colors.black.withOpacity(0.9),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      FluentIcons.shield_checkmark_48_filled,
                      color: AppColors.electricLilac,
                      size: 80,
                    )
                        .animate(onPlay: (c) => c.repeat())
                        .scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.2, 1.2),
                            duration: 1000.ms,
                            curve: Curves.easeInOut)
                        .then()
                        .scale(
                            begin: const Offset(1.2, 1.2),
                            end: const Offset(1, 1),
                            duration: 1000.ms,
                            curve: Curves.easeInOut),
                    const SizedBox(height: 32),
                    Text(
                      processingStatus,
                      style: const TextStyle(
                        color: AppColors.whiteColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'SF Pro',
                      ),
                    ).animate(target: 1).fadeIn(),
                    const SizedBox(height: 20),
                    const SizedBox(
                      width: 200,
                      child: LinearProgressIndicator(
                        backgroundColor: Colors.white12,
                        color: AppColors.electricLilac,
                      ),
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(duration: 300.ms),
        ],
      ),
    );
  }

  Widget _buildInput(
    String label,
    IconData icon,
    TextEditingController controller, {
    required int delay,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        style: const TextStyle(color: AppColors.whiteColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(icon, color: AppColors.grayColor),
          labelText: label,
          labelStyle: TextStyle(color: AppColors.grayColor.withOpacity(0.8)),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.2, end: 0);
  }
}
