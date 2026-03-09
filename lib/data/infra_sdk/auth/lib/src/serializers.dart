// @dart=3.5
// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_import

import 'package:one_of_serializer/any_of_serializer.dart';
import 'package:one_of_serializer/one_of_serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:auth_sdk/src/date_serializer.dart';
import 'package:auth_sdk/src/model/date.dart';

import 'package:auth_sdk/src/model/availability_check_info.dart';
import 'package:auth_sdk/src/model/complete_signup_verification_dto.dart';
import 'package:auth_sdk/src/model/create_account_dto.dart';
import 'package:auth_sdk/src/model/forgot_password_dto.dart';
import 'package:auth_sdk/src/model/o_auth_signin_dto.dart';
import 'package:auth_sdk/src/model/reset_password_dto.dart';
import 'package:auth_sdk/src/model/reset_password_otp_verification_response_payload.dart';
import 'package:auth_sdk/src/model/reset_password_verification_dto.dart';
import 'package:auth_sdk/src/model/signin_dto.dart';
import 'package:auth_sdk/src/model/signin_response_payload.dart';
import 'package:auth_sdk/src/model/signup_response_payload.dart';
import 'package:auth_sdk/src/model/signup_verification_response_payload.dart';

part 'serializers.g.dart';

@SerializersFor([
  AvailabilityCheckInfo,
  CompleteSignupVerificationDTO,
  CreateAccountDTO,
  ForgotPasswordDTO,
  OAuthSigninDTO,
  ResetPasswordDTO,
  ResetPasswordOTPVerificationResponsePayload,
  ResetPasswordVerificationDTO,
  SigninDTO,
  SigninResponsePayload,
  SignupResponsePayload,
  SignupVerificationResponsePayload,
])
Serializers serializers = (_$serializers.toBuilder()
      ..add(const OneOfSerializer())
      ..add(const AnyOfSerializer())
      ..add(const DateSerializer())
      ..add(Iso8601DateTimeSerializer())
    ).build();

Serializers standardSerializers =
    (serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
