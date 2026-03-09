// ignore_for_file: library_prefixes
import 'package:get/get.dart';
import 'package:account_sdk/account_sdk.dart'
    as AccountSdk;
import 'package:engagement_sdk/src/model/testimonial_info.dart'
    as EngagementSdk;

class UserRepository extends GetxController {
  Rx<AccountSdk.AccountInfo> accountInfo = AccountSdk.AccountInfo(
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
      ..referralCode = '',
  ).obs;

  final RxList<EngagementSdk.TestimonialInfo> _testimonials =
      <EngagementSdk.TestimonialInfo>[].obs;
  RxList<EngagementSdk.TestimonialInfo> get testimonials => _testimonials;

  final RxList<AccountSdk.MonthlySurveyInfo> _surveyHistory =
      <AccountSdk.MonthlySurveyInfo>[].obs;
  RxList<AccountSdk.MonthlySurveyInfo> get surveyHistory => _surveyHistory;

  final RxList<AccountSdk.NotificationInfo> _notifications =
      <AccountSdk.NotificationInfo>[].obs;
  RxList<AccountSdk.NotificationInfo> get notifications => _notifications;

  final RxList<AccountSdk.OrderInfo> _ongoingOrders =
      <AccountSdk.OrderInfo>[].obs;
  RxList<AccountSdk.OrderInfo> get ongoingOrders => _ongoingOrders;

  final RxList<AccountSdk.OrderInfo> _completedOrders =
      <AccountSdk.OrderInfo>[].obs;
  RxList<AccountSdk.OrderInfo> get completedOrders => _completedOrders;

  RxInt ordersCurrentPage = 1.obs;
  RxBool ordersHasNextPage = false.obs;

  RxInt notificationsCurrentPage = 1.obs;
  RxBool notificationsHasNextPage = false.obs;

  RxInt surveyHistoryCurrentPage = 1.obs;
  RxBool surveyHistoryHasNextPage = false.obs;
}
