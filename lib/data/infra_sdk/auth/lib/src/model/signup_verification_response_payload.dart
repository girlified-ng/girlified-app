// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signup_verification_response_payload.g.dart';

/// SignupVerificationResponsePayload
///
/// Properties:
/// * [token] 
@BuiltValue()
abstract class SignupVerificationResponsePayload implements Built<SignupVerificationResponsePayload, SignupVerificationResponsePayloadBuilder> {
  @BuiltValueField(wireName: r'token')
  String get token;

  SignupVerificationResponsePayload._();

  factory SignupVerificationResponsePayload([void updates(SignupVerificationResponsePayloadBuilder b)]) = _$SignupVerificationResponsePayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignupVerificationResponsePayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignupVerificationResponsePayload> get serializer => _$SignupVerificationResponsePayloadSerializer();
}

class _$SignupVerificationResponsePayloadSerializer implements PrimitiveSerializer<SignupVerificationResponsePayload> {
  @override
  final Iterable<Type> types = const [SignupVerificationResponsePayload, _$SignupVerificationResponsePayload];

  @override
  final String wireName = r'SignupVerificationResponsePayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignupVerificationResponsePayload object, {
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
    SignupVerificationResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignupVerificationResponsePayloadBuilder result,
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
  SignupVerificationResponsePayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignupVerificationResponsePayloadBuilder();
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

