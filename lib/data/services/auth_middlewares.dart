// ignore_for_file: library_prefixes
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:girlified/core/providers/index.dart';
import 'package:girlified/core/constants/routes.dart';
import 'package:girlified/core/constants/secrets.dart';
import 'package:built_collection/built_collection.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:account_sdk/account_sdk.dart' as AccountSdk;

void userLogoutHandler({
  BuildContext? context,
  bool hasContext = false,
  String displayMessage = 'Logged out!',
}) async {
  ServiceRegistry.googleSignIn.signOut();
  ServiceRegistry.localStorage.remove(LocalStorageSecrets.accessToken);
  ServiceRegistry.localStorage.remove(LocalStorageSecrets.authenticationMethod);

  if (hasContext == true) {
    Navigator.of(context!).pop();
  }

  customSuccessMessageSnackbar(
    title: 'Message',
    message: displayMessage,
  );

  ServiceRegistry.commonRepository.currentScreenIndex.value = 0;

  Get.toNamed(AppRoutes.loginRoute);

  await Future.delayed(const Duration(milliseconds: 300));

  ServiceRegistry.userRepository.accountInfo.value = AccountSdk.AccountInfo(
    (account) => account
      ..id = '0'
      ..firstName = ''
      ..lastName = ''
      ..phone = ''
      ..email = ''
      ..state = ''
      ..stateArea = ''
      ..accountType = AccountSdk.AccountInfoAccountTypeEnum.individual
      ..status = AccountSdk.AccountInfoStatusEnum.active
      ..profilePhoto =
          'https://medexer.s3.eu-north-1.amazonaws.com/avatars/avatar.png'
      ..fcmToken = ''
      ..referralCode = ''
      ..xHandle = ''
      ..instagramHandle = ''
      ..tiktokHandle = ''
      ..snapchatHandle = '',
  );
}
