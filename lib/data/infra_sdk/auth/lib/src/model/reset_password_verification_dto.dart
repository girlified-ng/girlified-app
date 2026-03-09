// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_verification_dto.g.dart';

/// ResetPasswordVerificationDTO
///
/// Properties:
/// * [email] - Account email.
/// * [otp] - Password reset token.
@BuiltValue()
abstract class ResetPasswordVerificationDTO implements Built<ResetPasswordVerificationDTO, ResetPasswordVerificationDTOBuilder> {
  /// Account email.
  @BuiltValueField(wireName: r'email')
  String get email;

  /// Password reset token.
  @BuiltValueField(wireName: r'otp')
  String get otp;

  ResetPasswordVerificationDTO._();

  factory ResetPasswordVerificationDTO([void updates(ResetPasswordVerificationDTOBuilder b)]) = _$ResetPasswordVerificationDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordVerificationDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordVerificationDTO> get serializer => _$ResetPasswordVerificationDTOSerializer();
}

class _$ResetPasswordVerificationDTOSerializer implements PrimitiveSerializer<ResetPasswordVerificationDTO> {
  @override
  final Iterable<Type> types = const [ResetPasswordVerificationDTO, _$ResetPasswordVerificationDTO];

  @override
  final String wireName = r'ResetPasswordVerificationDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordVerificationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'otp';
    yield serializers.serialize(
      object.otp,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ResetPasswordVerificationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResetPasswordVerificationDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'otp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.otp = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResetPasswordVerificationDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordVerificationDTOBuilder();
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

