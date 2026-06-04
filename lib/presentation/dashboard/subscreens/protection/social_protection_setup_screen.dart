import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:girlified/data/infra_sdk/account/lib/account_sdk.dart';
import 'package:girlified/core/utilities/protection_metrics.dart';

class SocialProtectionSetupScreen extends StatefulWidget {
  const SocialProtectionSetupScreen({super.key});

  @override
  State<SocialProtectionSetupScreen> createState() =>
      _SocialProtectionSetupScreenState();
}

class _SocialProtectionSetupScreenState extends State<SocialProtectionSetupScreen> {
  int currentStep = 0;

  // Step 1: Social Accounts
  final TextEditingController twitterController = TextEditingController();
  final TextEditingController instagramController = TextEditingController();
  final TextEditingController tiktokController = TextEditingController();
  final TextEditingController snapchatController = TextEditingController();

  // Step 2: Permissions
  bool hasVpnPermission = false;
  bool hasAccessibilityPermission = false;
  bool hasFamilyControls = false;

  // Step 3: Keywords
  final TextEditingController keywordController = TextEditingController();
List<String> keywords =[
  'throw shade', 'ghosting', 'flaming', 'cyberstalking',
  
  // Self-harm & Mental Health slang (Algospeak)
  'kys', 'kill yourself', 'kms', 'kill myself', 'sh', 'lms', 
  'unalive', 'sewer slide', 'menty b', 'stressy depressy', 
  'grippy sock vacation', 'blithe', 'i had pasta tonight', 'cutfor',
  'Kermit', 'd1ed', 'R-word', 'barcode', 'i\'m done', 'finishing',
  '2/3', 'drip code', 'slipped', 'falling', 'ghosting self',
  'disappearing', 'unplug', 'reset', 'shtwt', 'catscratchtwt',
  'babycuts', 'shbeans', 'cuttwt', 'styrofoam', 'scartwt',
  '#blithe', '#MySecretFamily', '#cuts', '#deb', '#sue',
  '#secretsociety123', '#selfharmmm', '#svv',
  
  // Eating disorder slang
  'ana', 'mia', 'thinspo', 'proana', 'bonespo', 'chew and spit',
  'CHSP', 'pro-ana', 'pro-mia', 'trigger foods', 'thinsta', 'edtwt',
  '#anas', '#mias', '#thinsp', '#proana', '#promia',
  
  // Explicit content & Grooming tactics
  'porn', 'nsfw', 'sex', 'nudes', 'onlyfans', 'camgirl',
  'gnoc', 'np4np', 'our x', 'iw2mu', 'mmas', 'mos', 'cd9',
  'DNI', 'DPW', 'Down in the DM', 'GNRN', 'GNOC', 'LMIRL',
  'NIFOC', 'NP4NP', 'P911', 'PIR', 'POS', 'TDTM', '1174',
  '9', '99', 'WTTP', 'IWSN', 'CU46', 'MPFB', 'DTF', 'PAL',
  'beat cake', 'seggs', 'seggsy', 'pr0n', 'corn', 'spicy corn',
  'OF', 'accountant', 'spicy content', 'seggsual', 'shug4r daddy',
  'shmex', 'corn star', '#cu46'
  ];

  // Step 4: PIN
  String enteredPin = '';
  String confirmPin = '';
  bool isConfirmingPin = false;

  bool isProtecting = false;
  String processingStatus = '';

  @override
  void initState() {
    super.initState();
    initializeControllers();
    _checkPermissions();
  }

  void initializeControllers() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      twitterController.text = ServiceRegistry.userRepository.accountInfo.value.xHandle;
      instagramController.text = ServiceRegistry.userRepository.accountInfo.value.instagramHandle;
      tiktokController.text = ServiceRegistry.userRepository.accountInfo.value.tiktokHandle;
      snapchatController.text = ServiceRegistry.userRepository.accountInfo.value.snapchatHandle;
    });
  }

  Future<void> _checkPermissions() async {
    final status = await ServiceRegistry.digitalSafeguardService.checkPermissionStatuses();
    if (mounted) {
      setState(() {
        hasVpnPermission = status['vpn'] ?? false;
        hasAccessibilityPermission = status['accessibility'] ?? false;
        hasFamilyControls = status['familyControls'] ?? false;
      });
    }
  }

  Future<void> _requestPermission(String type) async {
    final result = await ServiceRegistry.digitalSafeguardService.requestNativePermissions(type);
    if (result) {
      await _checkPermissions();
    }
  }

  void _nextStep() {
    if (currentStep == 0) {
      if (twitterController.text.isEmpty &&
          instagramController.text.isEmpty &&
          tiktokController.text.isEmpty &&
          snapchatController.text.isEmpty) {
        customErrorMessageSnackbar(
          title: 'Message',
          message: 'Please provide at least one social media handle',
        );
        return;
      }
    } else if (currentStep == 1) {
      // For demo, we might allow bypassing if they can't grant it in simulator
      // but ideally we check if permissions are granted.
    } else if (currentStep == 2) {
      if (keywords.isEmpty) {
        customErrorMessageSnackbar(
          title: 'Message',
          message: 'Please provide at least one keyword to monitor',
        );
        return;
      }
    } else if (currentStep == 3) {
      if (enteredPin.length < 4) {
        customErrorMessageSnackbar(
          title: 'Message',
          message: 'PIN must be at least 4 digits',
        );
        return;
      }
      _handleProtect();
      return;
    }

    setState(() {
      currentStep++;
    });
  }

  void _previousStep() {
    setState(() {
      currentStep--;
    });
  }

  void _addKeyword(String keyword) {
    if (keyword.isNotEmpty && !keywords.contains(keyword.toLowerCase())) {
      setState(() {
        keywords.add(keyword.toLowerCase());
        keywordController.clear();
      });
    }
  }

  void _removeKeyword(String keyword) {
    setState(() {
      keywords.remove(keyword);
    });
  }

  Future<void> _handleProtect() async {
    setState(() {
      isProtecting = true;
    });

    // Save Social Media Handles
    await ServiceRegistry.accountService.updateAccountSocialHandlesService(UpdateSocialHandlesDTO((b) => b
      ..xHandle = twitterController.text
      ..instagramHandle = instagramController.text
      ..tiktokHandle = tiktokController.text
      ..snapchatHandle = snapchatController.text));
      
    // Save PIN
    await ServiceRegistry.localStorage.write('protection_pin', enteredPin);
    
    // Save Keywords
    await ServiceRegistry.localStorage.write('protection_keywords', keywords);

    // Call Native Service
    await ServiceRegistry.digitalSafeguardService.startDigitalSafeguard(keywords);

    final steps = [
      'Connecting to Social Accounts...',
      'Configuring Native Hooks...',
      'Activating Neural Shield...',
      'Protection Enabled!',
    ];

    for (var step in steps) {
      if (!mounted) return;
      setState(() {
        processingStatus = step;
      });
      await Future.delayed(const Duration(milliseconds: 1000));
    }

    await ServiceRegistry.localStorage.write('protection_active', true);
    ProtectionMetricsHelper.logProtectionStateChange(true);

    if (!mounted) return;
    Get.offAllNamed(AppRoutes.dashboardRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkThemeBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: currentStep > 0 && !isProtecting
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: _previousStep,
              )
            : IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Get.back(),
              ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(4, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 20,
              height: 4,
              decoration: BoxDecoration(
                color: index <= currentStep ? AppColors.electricLilac : Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            );
          }),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _buildCurrentStep(),
                    ),
                  ),
                ),
                if (!isProtecting)
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _nextStep,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.electricLilac,
                          foregroundColor: AppColors.whiteColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: AppColors.electricLilac.withOpacity(0.5),
                        ),
                        child: Text(
                          currentStep == 3 ? 'Activate Protection' : 'Continue',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SF Pro',
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          if (isProtecting) _buildProcessingOverlay(),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 0:
        return _buildAccountsStep();
      case 1:
        return _buildPermissionsStep();
      case 2:
        return _buildKeywordsStep();
      case 3:
        return _buildPinStep();
      default:
        return const SizedBox();
    }
  }

  Widget _buildAccountsStep() {
    return Column(
      key: const ValueKey('step0'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect Accounts',
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
          'We need to know which accounts to protect.',
          style: TextStyle(
            color: AppColors.whiteColor.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'SF Pro',
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 40),
        _buildInput('Twitter / X', FluentIcons.mention_24_regular, twitterController, delay: 400),
        const SizedBox(height: 16),
        _buildInput('Instagram', FluentIcons.camera_24_regular, instagramController, delay: 500),
        const SizedBox(height: 16),
        _buildInput('TikTok', FluentIcons.video_24_regular, tiktokController, delay: 600),
        const SizedBox(height: 16),
        _buildInput('Snapchat', FluentIcons.chat_24_regular, snapchatController, delay: 700),
      ],
    );
  }

  Widget _buildPermissionsStep() {
    return Column(
      key: const ValueKey('step1'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'System Access',
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
          'Grant necessary permissions to enable local filtering and shielding.',
          style: TextStyle(
            color: AppColors.whiteColor.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'SF Pro',
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 40),
        if (Platform.isAndroid) ...[
          _buildPermissionTile(
            'Accessibility Service',
            'Required to scan screen contents for harassment and overlay warnings.',
            hasAccessibilityPermission,
            () => _requestPermission('accessibility'),
          ),
        ] else if (Platform.isIOS) ...[
          _buildPermissionTile(
            'Screen Time & Family Controls',
            'Required to shield targeted apps during distress events.',
            hasFamilyControls,
            () => _requestPermission('familyControls'),
          ),
        ],
      ],
    );
  }

  Widget _buildPermissionTile(String title, String subtitle, bool isGranted, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isGranted ? AppColors.tealColor : Colors.white.withOpacity(0.1)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        title: Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.white.withOpacity(0.7))),
        trailing: isGranted
            ? const Icon(FluentIcons.checkmark_circle_24_filled, color: AppColors.tealColor)
            : ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.electricLilac,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text('Grant', style: TextStyle(color: Colors.white)),
              ),
      ),
    ).animate().fadeIn().slideX();
  }

  Widget _buildKeywordsStep() {
    return Column(
      key: const ValueKey('step2'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Harassment Filter',
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
          'Add words or phrases you want SaifeAI to instantly block from your view.',
          style: TextStyle(
            color: AppColors.whiteColor.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'SF Pro',
          ),
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              child: _buildInput('Add keyword...', FluentIcons.add_24_regular, keywordController, delay: 0),
            ),
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(FluentIcons.add_circle_24_filled, color: AppColors.electricLilac, size: 32),
              onPressed: () => _addKeyword(keywordController.text),
            )
          ],
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: keywords.map((kw) => Chip(
            label: Text(kw, style: const TextStyle(color: Colors.black)),
            backgroundColor: AppColors.electricLilac.withOpacity(0.2),
            deleteIcon: const Icon(Icons.close, size: 16, color: Colors.white70),
            onDeleted: () => _removeKeyword(kw),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: AppColors.electricLilac.withOpacity(0.5)),
            ),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildPinStep() {
    return Column(
      key: const ValueKey('step3'),
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Secure Your Settings',
          style: TextStyle(
            color: AppColors.whiteColor,
            fontSize: 32,
            fontWeight: FontWeight.bold,
            fontFamily: 'SF Pro',
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn().slideY(begin: 0.3, end: 0),
        const SizedBox(height: 16),
        Text(
          isConfirmingPin ? 'Confirm your PIN.' : 'Create a 4-to-6 digit PIN to lock protection off switches and settings.',
          style: TextStyle(
            color: AppColors.whiteColor.withOpacity(0.7),
            fontSize: 16,
            fontFamily: 'SF Pro',
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            String current = isConfirmingPin ? confirmPin : enteredPin;
            bool isFilled = index < current.length;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isFilled ? AppColors.electricLilac : Colors.transparent,
                border: Border.all(color: AppColors.electricLilac, width: 2),
              ),
            );
          }),
        ),
        const SizedBox(height: 40),
        _buildDialPad(),
      ],
    );
  }

  Widget _buildDialPad() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        for (var i = 1; i <= 9; i++) _buildDialButton(i.toString()),
        _buildDialButton('Clear', isAction: true),
        _buildDialButton('0'),
        _buildDialButton('Next', isAction: true),
      ],
    );
  }

  Widget _buildDialButton(String text, {bool isAction = false}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (text == 'Clear') {
            if (isConfirmingPin) {
              if (confirmPin.isNotEmpty) confirmPin = confirmPin.substring(0, confirmPin.length - 1);
            } else {
              if (enteredPin.isNotEmpty) enteredPin = enteredPin.substring(0, enteredPin.length - 1);
            }
          } else if (text == 'Next') {
             if (!isConfirmingPin) {
               if (enteredPin.length >= 4) {
                 isConfirmingPin = true;
               } else {
                 customErrorMessageSnackbar(title: 'Error', message: 'PIN must be at least 4 digits');
               }
             } else {
               if (confirmPin == enteredPin) {
                 _nextStep();
               } else {
                 customErrorMessageSnackbar(title: 'Error', message: 'PINs do not match');
                 confirmPin = '';
               }
             }
          } else {
            if (isConfirmingPin) {
              if (confirmPin.length < 6) confirmPin += text;
            } else {
              if (enteredPin.length < 6) enteredPin += text;
            }
          }
        });
      },
      borderRadius: BorderRadius.circular(32),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: isAction ? AppColors.electricLilac : Colors.white,
            fontSize: isAction ? 18 : 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildProcessingOverlay() {
    return Container(
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
                .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2), duration: 1000.ms, curve: Curves.easeInOut)
                .then()
                .scale(begin: const Offset(1.2, 1.2), end: const Offset(1, 1), duration: 1000.ms, curve: Curves.easeInOut),
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
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildInput(String label, IconData icon, TextEditingController controller, {required int delay}) {
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
