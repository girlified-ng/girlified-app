import 'package:test/test.dart';
import 'package:auth_sdk/auth_sdk.dart';


/// tests for PasswordApi
void main() {
  final instance = AuthSdk().getPasswordApi();

  group(PasswordApi, () {
    //Future authControllerForgotPassword(ForgotPasswordDTO forgotPasswordDTO) async
    test('test authControllerForgotPassword', () async {
      // TODO
    });

    //Future authControllerResetPassword(ResetPasswordDTO resetPasswordDTO) async
    test('test authControllerResetPassword', () async {
      // TODO
    });

    //Future<ResetPasswordOTPVerificationResponsePayload> authControllerResetPasswordOtpVerification(ResetPasswordVerificationDTO resetPasswordVerificationDTO) async
    test('test authControllerResetPasswordOtpVerification', () async {
      // TODO
    });

  });
}
