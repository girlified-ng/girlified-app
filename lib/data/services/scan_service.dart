import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:girlified/components/snackbars/custom_snackbar.dart';
import 'package:girlified/core/middlewares/core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import 'package:dio/src/form_data.dart' as FormData;
import 'package:dio/src/multipart_file.dart' as MultipartFile;

class ScanController extends GetxController {
  final Dio _dio = Dio();

  RxString email = ''.obs;
  RxString firstName = ''.obs;

  GetStorage localStorage = GetStorage();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _loadUserDetails();
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

    String emaill = localStorage.read('email').toString();

    final uri =
        'https://venille-api.livestocx.xyz/v1/auth/generate-girlified-smart-pad-report?email=$emaill&name=${emaill.split('@')[0]}';

    final formData = FormData.FormData.fromMap({
      'file': await MultipartFile.MultipartFile.fromFile(
        imageFile.path,
        filename: imageName,
        contentType:
            DioMediaType('image', 'jpeg'), // or 'png' depending on file
      ),
    });
    log(email.value);

    try {
      final res = await _dio.post(uri,
          data: formData,
          options: Options(headers: {
            'Content-Type': 'multipart/form-data',
            'Accept': 'application/json',
          }));
      if (res.statusCode == 200 || res.statusCode == 201) {
        print('[IMAGE]');
        customSuccessMessageSnackbar(
            title: 'Success', message: 'Image uploaded successful');
        print('Email: ${email.value}, First Name: ${firstName.value}');
      } else {
        customErrorMessageSnackbar(
            title: 'Error', message: 'Upload failed: ${res.statusCode}');
      }
    } catch (e) {
      log(e.toString());
      customErrorMessageSnackbar(
          title: 'Error', message: 'Upload failed: ${e.toString()}');
    }
  }
}
