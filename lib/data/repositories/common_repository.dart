import 'package:get/get.dart';
import 'package:girlified/core/models/user_country_model.dart';

class CommonRepository extends GetxController {
  RxInt currentScreenIndex = 0.obs;

  Rx<UserCountryModel> userCountry = UserCountryModel(
    name: 'Nigeria',
    dialCode: '+234',
    flagEmoji: '🇳🇬',
  ).obs;
}
