// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'reset_password_dto.g.dart';

/// ResetPasswordDTO
///
/// Properties:
/// * [newPassword] - Account password.
/// * [passwordResetToken] - Password reset token.
/// * [accountId] - Account Id.
@BuiltValue()
abstract class ResetPasswordDTO implements Built<ResetPasswordDTO, ResetPasswordDTOBuilder> {
  /// Account password.
  @BuiltValueField(wireName: r'newPassword')
  String get newPassword;

  /// Password reset token.
  @BuiltValueField(wireName: r'passwordResetToken')
  String get passwordResetToken;

  /// Account Id.
  @BuiltValueField(wireName: r'accountId')
  String get accountId;

  ResetPasswordDTO._();

  factory ResetPasswordDTO([void updates(ResetPasswordDTOBuilder b)]) = _$ResetPasswordDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ResetPasswordDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ResetPasswordDTO> get serializer => _$ResetPasswordDTOSerializer();
}

class _$ResetPasswordDTOSerializer implements PrimitiveSerializer<ResetPasswordDTO> {
  @override
  final Iterable<Type> types = const [ResetPasswordDTO, _$ResetPasswordDTO];

  @override
  final String wireName = r'ResetPasswordDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ResetPasswordDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPassword';
    yield serializers.serialize(
      object.newPassword,
      specifiedType: const FullType(String),
    );
    yield r'passwordResetToken';
    yield serializers.serialize(
      object.passwordResetToken,
      specifiedType: const FullType(String),
    );
    yield r'accountId';
    yield serializers.serialize(
      object.accountId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ResetPasswordDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ResetPasswordDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newPassword':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPassword = valueDes;
          break;
        case r'passwordResetToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.passwordResetToken = valueDes;
          break;
        case r'accountId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.accountId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ResetPasswordDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ResetPasswordDTOBuilder();
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

