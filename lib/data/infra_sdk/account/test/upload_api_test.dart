import 'package:test/test.dart';
import 'package:account_sdk/account_sdk.dart';


/// tests for UploadApi
void main() {
  final instance = AccountSdk().getUploadApi();

  group(UploadApi, () {
    // Upload an file
    //
    //Future<FileUploadResult> imageUploadControllerUploadFile({ MultipartFile file }) async
    test('test imageUploadControllerUploadFile', () async {
      // TODO
    });

    // Upload an image with optional resizing
    //
    //Future<FileUploadResult> imageUploadControllerUploadImage({ String type, MultipartFile file }) async
    test('test imageUploadControllerUploadImage', () async {
      // TODO
    });

  });
}
