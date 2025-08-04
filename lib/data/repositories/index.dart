// ignore_for_file: unused_local_variable
import 'package:get/get.dart';
import 'package:girlified/data/repositories/user_repository.dart';
import 'package:girlified/data/repositories/common_repository.dart';
import 'package:girlified/data/services/authentication_service.dart';

class RootRepository extends GetxController {
  initialize() {
    Get.put(CommonRepository());

    Get.put(UserRepository());

    Get.put(AuthenticationService());
  }
}
