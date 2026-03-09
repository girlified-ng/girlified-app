// Updated typedef with a generic type parameter
import 'dart:developer';
import 'package:get_storage/get_storage.dart';
import 'package:girlified/core/constants/secrets.dart';

GetStorage localStorage = GetStorage();

typedef AsyncFunc<T> = Future<T> Function();

Future<T?> authGuard<T>(AsyncFunc<T> func) async {
  if (localStorage.read(LocalStorageSecrets.accessToken) == null &&
      localStorage.read(LocalStorageSecrets.authenticationMethod) == 'SECURE') {
    log('UNAUTHORIZED -> NO_ACCESS_TOKEN_FOUND');

    return null;
  }

  return await func();
}
