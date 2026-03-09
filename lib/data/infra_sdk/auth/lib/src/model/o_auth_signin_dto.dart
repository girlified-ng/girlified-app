// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'o_auth_signin_dto.g.dart';

/// OAuthSigninDTO
///
/// Properties:
/// * [email] - Account email.
@BuiltValue()
abstract class OAuthSigninDTO implements Built<OAuthSigninDTO, OAuthSigninDTOBuilder> {
  /// Account email.
  @BuiltValueField(wireName: r'email')
  String get email;

  OAuthSigninDTO._();

  factory OAuthSigninDTO([void updates(OAuthSigninDTOBuilder b)]) = _$OAuthSigninDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OAuthSigninDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OAuthSigninDTO> get serializer => _$OAuthSigninDTOSerializer();
}

class _$OAuthSigninDTOSerializer implements PrimitiveSerializer<OAuthSigninDTO> {
  @override
  final Iterable<Type> types = const [OAuthSigninDTO, _$OAuthSigninDTO];

  @override
  final String wireName = r'OAuthSigninDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OAuthSigninDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OAuthSigninDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OAuthSigninDTOBuilder result,
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
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OAuthSigninDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OAuthSigninDTOBuilder();
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

