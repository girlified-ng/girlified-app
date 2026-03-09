// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_otp_verification_response_payload.g.dart';

/// ResetPasswordOTPVerificationResponsePayload
///
/// Properties:
/// * [accountId] - Account Id.
/// * [passwordResetToken] - Password reset token
@BuiltValue()
abstract class ResetPasswordOTPVerificationResponsePayload implements Built<ResetPasswordOTPVerificationResponsePayload, ResetPasswordOTPVerificationResponsePayloadBuilder> {
  /// Account Id.
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  /// Password reset token
  @BuiltValueField(wireName: r'passwordResetToken')
  String get passwordResetToken;

  ResetPasswordOTPVerificationResponsePayload._();

  factory ResetPasswordOTPVerificationResponsePayload([void updates(ResetPasswordOTPVerificationResponsePayloadBuilder b)]) = _$ResetPasswordOTPVerificationResponsePayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordOTPVerificationResponsePayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordOTPVerificationResponsePayload> get serializer => _$ResetPasswordOTPVerificationResponsePayloadSerializer();
}

class _$ResetPasswordOTPVerificationResponsePayloadSerializer implements PrimitiveSerializer<ResetPasswordOTPVerificationResponsePayload> {
  @override
  final Iterable<Type> types = const [ResetPasswordOTPVerificationResponsePayload, _$ResetPasswordOTPVerificationResponsePayload];

  @override
  final String wireName = r'ResetPasswordOTPVerificationResponsePayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordOTPVerificationResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
    yield r'passwordResetToken';
    yield serializers.serialize(
      object.passwordResetToken,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ResetPasswordOTPVerificationResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResetPasswordOTPVerificationResponsePayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        case r'passwordResetToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.passwordResetToken = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResetPasswordOTPVerificationResponsePayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordOTPVerificationResponsePayloadBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

