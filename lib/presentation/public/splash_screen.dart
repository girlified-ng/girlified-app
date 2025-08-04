import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/colors.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:flutter_animate/flutter_animate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initializeTimeOut() async {
    await Future.delayed(const Duration(milliseconds: 1500));

    if (ServiceRegistry.localStorage.read(LocalStorageSecrets.accessToken) !=
        null) {
      ServiceRegistry.commonRepository.currentScreenIndex.value = 0;

      // Get.toNamed(AppRoutes.dashboardRoute);
    } else {
      Get.toNamed(AppRoutes.loginRoute);
    }
  }

  @override
  void initState() {
    initializeTimeOut();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Animate(
                effects: const [
                  FadeEffect(duration: Duration(milliseconds: 0)),
                  SlideEffect(
                    end: Offset(0, 0),
                    begin: Offset(0, -0.3),
                    duration: Duration(milliseconds: 1200),
                  ),
                ],
                child: Image.asset(
                  'assets/icons/icon_logo_cliff.png',
                  width: 140,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
