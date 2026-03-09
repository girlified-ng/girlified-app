// ignore_for_file: unused_local_variable
import 'package:get/get.dart';
import 'package:girlified/data/services/order_service.dart';
import 'package:girlified/data/services/account_service.dart';
import 'package:girlified/data/services/engagement_service.dart';
import 'package:girlified/data/repositories/user_repository.dart';
import 'package:girlified/data/repositories/common_repository.dart';
import 'package:girlified/data/services/authentication_service.dart';

class RootRepository extends GetxController {
  initialize() {
    Get.put(CommonRepository());

    Get.put(UserRepository());

    Get.put(OrderService());

    Get.put(AccountService());

    Get.put(AuthenticationService());

    Get.put(EngagementService());
  }
}
