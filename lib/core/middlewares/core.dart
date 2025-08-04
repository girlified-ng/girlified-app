import 'dart:io';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:flutter_upgrade_version/flutter_upgrade_version.dart';

class AppUpdateService {
  static final AppUpdateService _instance = AppUpdateService._internal();
  factory AppUpdateService() => _instance;
  AppUpdateService._internal();

  late PackageInfo _packageInfo;
  final GetStorage localStorage = GetStorage();
  final InAppUpdateManager _manager = InAppUpdateManager();

  Future<void> initialize() async {
    await Future.delayed(const Duration(milliseconds: 4500));

    _packageInfo = await PackageManager.getPackageInfo();

    await checkForUpdate();

    // Check for pending background notifications
    // handleBackgroundPushNotificationLocalRoutes();
  }

  Future<void> checkForUpdate() async {
    if (Platform.isAndroid) {
      await _handleAndroidUpdate();
    } else if (Platform.isIOS) {
      await _handleIOSUpdate();
    }
  }

  Future<void> _handleAndroidUpdate() async {
    AppUpdateInfo? appUpdateInfo = await _manager.checkForUpdate();

    if (appUpdateInfo == null) return;

    if (appUpdateInfo.updateAvailability ==
        UpdateAvailability.developerTriggeredUpdateInProgress) {
      // await _manager.startAnUpdate(
      //   type: AppUpdateType.immediate,
      // );
      Get.toNamed(AppRoutes.appUpdateRoute);
    } else if (appUpdateInfo.updateAvailability ==
        UpdateAvailability.updateAvailable) {
      if (appUpdateInfo.immediateAllowed) {
        // await _manager.startAnUpdate(
        //   type: AppUpdateType.immediate,
        // );
        Get.toNamed(AppRoutes.appUpdateRoute);
      } else if (appUpdateInfo.flexibleAllowed) {
        // await _manager.startAnUpdate(
        //   type: AppUpdateType.flexible,
        // );
        Get.toNamed(AppRoutes.appUpdateRoute);
      }
    }
  }

  Future<void> _handleIOSUpdate() async {
    final currentVersion = _packageInfo.version;

    final VersionInfo versionInfo = await UpgradeVersion.getiOSStoreVersion(
      packageInfo: _packageInfo,
    );

    final storeVersion = versionInfo.storeVersion;

    log('[IOS_STORE_VERSION] :: $storeVersion');
    log('[IOS_CURRENT_VERSION] :: $currentVersion');

    if (storeVersion != currentVersion) {
      await _manager.startAnUpdate(
        type: AppUpdateType.flexible,
      );
      // Get.toNamed(AppRoutes.appUpdateRoute);
    }
  }
}
