import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/core/middlewares/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class ScanController extends GetxController {
  final Dio _dio = Dio();

  RxString email = ''.obs;
  RxString firstName = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  Future<void> _loadUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email') ?? '';

    email.value = storedEmail;

    if (storedEmail.isNotEmpty) {
      final namePart = storedEmail.split('@').first;
      firstName.value =
          namePart[0].toUpperCase() + namePart.substring(1).toLowerCase();
    }
  }

  Future<void> upLoadImage(File imageFile) async {
    final imageName = path.basename(imageFile.path);
    final uri =
        'https://venille-api.livestocx.xyz/v1/auth/generate-girlified-smart-pad-report?email=${email.value}&name=${firstName.value}';

    final body = {
      'imageName': imageName,
    };

    try {
      final res = await _dio.post(uri,
          data: body,
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          }));
      if (res.statusCode == 200 || res.statusCode == 201) {
        customSuccessMessageSnackbar(
            title: 'Sucsess', message: 'Image uploaded successful');
      } else {
        customErrorMessageSnackbar(
            title: 'Error', message: 'Upload failed: ${res.statusCode}');
      }
    } catch (e) {
      customErrorMessageSnackbar(
          title: 'Error', message: 'Upload failed: ${e.toString()}');
    }
  }
}
