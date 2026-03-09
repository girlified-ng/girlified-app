import 'package:test/test.dart';
import 'package:auth_sdk/auth_sdk.dart';


/// tests for AuthApi
void main() {
  final instance = AuthSdk().getAuthApi();

  group(AuthApi, () {
    //Future<SigninResponsePayload> authControllerSignIn(SigninDTO signinDTO) async
    test('test authControllerSignIn', () async {
      // TODO
    });

    //Future<SignupResponsePayload> authControllerSignUp(CreateAccountDTO createAccountDTO) async
    test('test authControllerSignUp', () async {
      // TODO
    });

    //Future<SigninResponsePayload> authControllerSigninOAuth(OAuthSigninDTO oAuthSigninDTO) async
    test('test authControllerSigninOAuth', () async {
      // TODO
    });

    //Future<SignupVerificationResponsePayload> authControllerSignupCompleteVerification(CompleteSignupVerificationDTO completeSignupVerificationDTO) async
    test('test authControllerSignupCompleteVerification', () async {
      // TODO
    });

  });
}
