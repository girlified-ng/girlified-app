import 'package:get/get.dart';
import 'package:girlified/presentation/authentication/forgot_password/forgot_password_otp_verification_screen.dart';
import 'package:girlified/presentation/authentication/forgot_password/forgot_password_screen.dart';
import 'package:girlified/presentation/authentication/forgot_password/reset_password_screen.dart';
import 'package:girlified/presentation/authentication/signup/signup_create_password_screen.dart';
import 'package:girlified/presentation/authentication/signup/signup_screen.dart';
import 'package:girlified/presentation/authentication/signup/signup_verification_screen.dart';
import 'package:girlified/presentation/dashboard/dashboard.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/account_details_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/account_email/update_account_verify_email_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/account_name/update_account_name_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/account_password/update_account_password_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/account_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/account/help/help_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/orders/order_pad_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/support/support_screen.dart';
import 'package:girlified/presentation/public/onboarding_screen.dart';
import 'package:girlified/presentation/public/splash_screen.dart';
import 'package:girlified/presentation/authentication/login/login_screen.dart';
import 'package:girlified/presentation/dashboard/subscreens/protection/social_protection_setup_screen.dart';

class AppRoutes {
  /// ROOT_SCREEN_ROUTE
  ///
  /// Navigates to splash screen
  static const String rootRoute = '/';

  /// APP_UPDATE_SCREEN_ROUTE
  ///
  /// Navigates to app update screen
  static const String appUpdateRoute = '/APP_UPDATE_SCREEN_ROUTE';

  /// ONBOARDING_SCREEN_ROUTE
  ///
  /// Navigates to onboarding screen
  static const String onboardingRoute = '/ONBOARDING_ROUTE';

  /// DASHBOARD_SCREEN_ROUTE
  ///
  /// Navigates to dashboard screen
  static const String dashboardRoute = '/DASHBOARD_ROUTE';

  /// NOTIFICATIONS_SCREEN_ROUTE
  ///
  /// Navigates to dashboard screen
  static const String notificationsRoute = '/NOTIFICATIONS_ROUTE';

  /// LOGIN_SCREEN_ROUTE
  ///
  /// Navigates to login screen
  static const String loginRoute = '/LOGIN_ROUTE';

  /// FORGOT_PASSWORD_SCREEN_ROUTE
  ///
  /// Navigates to forgot password screen
  static const String forgotPasswordRoute = '/FORGOT_PASSWORD_ROUTE';

  /// FORGOT_PASSWORD_OTP_VERIFICATION_SCREEN_ROUTE
  ///
  /// Navigates to forgot password otp verification screen
  static const String forgotPasswordOtpVerificationRoute =
      '/FORGOT_PASSWORD_OTP_VERIFICATION_ROUTE';

  /// RESET_PASSWORD_SCREEN_ROUTE
  ///
  /// Navigates to reset password screen
  static const String resetPasswordRoute = '/RESET_PASSWORD_ROUTE';

  /// SIGN_UP_SCREEN_ROUTE
  ///
  /// Navigates to sign up screen
  static const String signUpRoute = '/SIGN_UP_ROUTE';

  /// SIGNUP CREATE PASSWORD SCREEN_ROUTE
  ///
  /// Navigates to sign up create password screen
  static const String signUpCreatePasswordRoute =
      '/SIGN_UP_CREATE_PASSWORD_ROUTE';

  /// SIGN_UP_VERIFICATION_SCREEN_ROUTE
  ///
  /// Navigates to sign up verification screen
  static const String signUpVerificationRoute = '/SIGN_UP_VERIFICATION_ROUTE';

  /// SOCIAL_PROTECTION_SETUP_ROUTE
  ///
  /// Navigates to social protection setup screen
  static const String socialProtectionSetupRoute =
      '/SOCIAL_PROTECTION_SETUP_ROUTE';

  /// ORDER_PAD_ROUTE
  ///
  /// Navigates to order pad screen
  static const String orderPadRoute = '/ORDER_PAD_ROUTE';

  /// ACCOUNT_ROUTE
  ///
  /// Navigates to account screen
  static const String accountRoute = '/ACCOUNT_ROUTE';

  /// ACCOUNT_DETAILS_ROUTE
  ///
  /// Navigates to account details screen
  static const String accountDetailsRoute = '/ACCOUNT_DETAILS_ROUTE';

  /// UPDATE_ACCOUNT_VERIFY_EMAIL_ROUTE
  ///
  /// Navigates to update account verify email screen
  static const String updateAccountVerifyEmailRoute =
      '/UPDATE_ACCOUNT_VERIFY_EMAIL_ROUTE';

  /// UPDATE_ACCOUNT_NAME_ROUTE
  ///
  /// Navigates to update account name screen
  static const String updateAccountNameRoute = '/UPDATE_ACCOUNT_NAME_ROUTE';

  /// UPDATE_ACCOUNT_PASSWORD_ROUTE
  ///
  /// Navigates to update account password screen
  static const String updateAccountPasswordRoute =
      '/UPDATE_ACCOUNT_PASSWORD_ROUTE';

  /// HELP_ROUTE
  ///
  /// Navigates to help screen
  static const String helpRoute = '/HELP_ROUTE';

  /// SUPPORT_ROUTE
  ///
  /// Navigates to support screen
  static const String supportRoute = '/SUPPORT_ROUTE';

  static List<GetPage> routes = [
    // PUBLIC
    GetPage(
      name: rootRoute,
      page: () => const SplashScreen(),
    ),

    GetPage(
      name: onboardingRoute,
      page: () => const OnboardingScreen(),
    ),

    // AUTHENTICATION
    GetPage(
      name: loginRoute,
      page: () => const LoginScreen(),
    ),

    // SIGNUP
    GetPage(
      name: signUpRoute,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: signUpCreatePasswordRoute,
      page: () => const SignupCreatePasswordScreen(),
    ),
    GetPage(
      name: signUpVerificationRoute,
      page: () => const SignupVerificationScreen(),
    ),

    // FORGOT PASSWORD
    GetPage(
      name: forgotPasswordRoute,
      page: () => const ForgotPasswordScreen(),
    ),
    GetPage(
      name: forgotPasswordOtpVerificationRoute,
      page: () => const ForgotPasswordOtpVerificationScreen(),
    ),
    GetPage(
      name: resetPasswordRoute,
      page: () => const ResetPasswordScreen(),
    ),

    // ONBOARDING
    GetPage(
      name: socialProtectionSetupRoute,
      page: () => const SocialProtectionSetupScreen(),
    ),

    // DASHBOARD
    GetPage(
      name: dashboardRoute,
      page: () => const Dashboard(),
    ),

    // ACCOUNT
    GetPage(
      name: accountRoute,
      page: () => const AccountScreen(),
    ),

    // ORDER PAD
    GetPage(
      name: orderPadRoute,
      page: () => const OrderPadScreen(),
    ),

    // ACCOUNT DETAILS
    GetPage(
      name: accountDetailsRoute,
      page: () => const AccountDetailsScreen(),
    ),

    // UPDATE ACCOUNT NAME
    GetPage(
      name: updateAccountNameRoute,
      page: () => const UpdateAccountNameScreen(),
    ),

    // UPDATE ACCOUNT PASSWORD
    GetPage(
      name: updateAccountPasswordRoute,
      page: () => const UpdateAccountPasswordScreen(),
    ),

    // UPDATE ACCOUNT VERIFY EMAIL
    GetPage(
      name: updateAccountVerifyEmailRoute,
      page: () => const UpdateAccountVerifyEmailScreen(),
    ),

    // HELP
    GetPage(
      name: helpRoute,
      page: () => const HelpScreen(),
    ),

    // SUPPORT
    GetPage(
      name: supportRoute,
      page: () => const SupportScreen(),
    ),
  ];
}
