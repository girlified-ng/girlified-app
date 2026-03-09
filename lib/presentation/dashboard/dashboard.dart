// ignore_for_file: use_build_context_synchronously
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:girlified/presentation/dashboard/orders_screen.dart';
import 'package:girlified/presentation/dashboard/protection_dashboard_screen.dart';
import 'package:girlified/presentation/dashboard/activity_screen.dart';
import 'package:girlified/presentation/dashboard/settings_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/account_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/protection/social_protection_setup_screen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  DateTime? currentBackPressTime;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void initializeAppInfo() {}

  final List<Widget> screens = [
    
    const OrdersScreen(),
    // const ProtectionDashboardScreen(),
    const SocialProtectionSetupScreen(),
    const ActivityScreen(),
    const AccountScreen(),
  ];

  void initializeDashboardAuth() async {
    await Future.delayed(const Duration(milliseconds: 80));

    if (ServiceRegistry.localStorage.read(LocalStorageSecrets.accessToken) ==
            null &&
        ServiceRegistry.localStorage
                .read(LocalStorageSecrets.authenticationMethod) ==
            'SECURE') {
      Get.toNamed(AppRoutes.loginRoute);
    }
  }

  void initializeCoreServices() async {
    await Future.delayed(const Duration(seconds: 6));
  }

  @override
  initState() {
    initializeAppInfo();

    initializeCoreServices();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          key: scaffoldKey,
          body: screens[
              ServiceRegistry.commonRepository.currentScreenIndex.value],
        ),
      );
    });
  }
}
