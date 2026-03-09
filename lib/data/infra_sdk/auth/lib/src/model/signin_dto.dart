// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signin_dto.g.dart';

/// SigninDTO
///
/// Properties:
/// * [email] - Account email.
/// * [password] - Account password.
@BuiltValue()
abstract class SigninDTO implements Built<SigninDTO, SigninDTOBuilder> {
  /// Account email.
  @BuiltValueField(wireName: r'email')
  String get email;

  /// Account password.
  @BuiltValueField(wireName: r'password')
  String get password;

  SigninDTO._();

  factory SigninDTO([void updates(SigninDTOBuilder b)]) = _$SigninDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SigninDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SigninDTO> get serializer => _$SigninDTOSerializer();
}

class _$SigninDTOSerializer implements PrimitiveSerializer<SigninDTO> {
  @override
  final Iterable<Type> types = const [SigninDTO, _$SigninDTO];

  @override
  final String wireName = r'SigninDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SigninDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SigninDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SigninDTOBuilder result,
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
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SigninDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SigninDTOBuilder();
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

