// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signin_response_payload.g.dart';

/// SigninResponsePayload
///
/// Properties:
/// * [token] 
@BuiltValue()
abstract class SigninResponsePayload implements Built<SigninResponsePayload, SigninResponsePayloadBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  SigninResponsePayload._();

  factory SigninResponsePayload([void updates(SigninResponsePayloadBuilder b)]) = _$SigninResponsePayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SigninResponsePayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SigninResponsePayload> get serializer => _$SigninResponsePayloadSerializer();
}

class _$SigninResponsePayloadSerializer implements PrimitiveSerializer<SigninResponsePayload> {
  @override
  final Iterable<Type> types = const [SigninResponsePayload, _$SigninResponsePayload];

  @override
  final String wireName = r'SigninResponsePayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SigninResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'token';
    yield serializers.serialize(
      object.token,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SigninResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SigninResponsePayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'token':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.token = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SigninResponsePayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SigninResponsePayloadBuilder();
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

