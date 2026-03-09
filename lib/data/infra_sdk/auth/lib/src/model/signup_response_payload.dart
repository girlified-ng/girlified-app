// @dart=3.5
// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'signup_response_payload.g.dart';

/// SignupResponsePayload
///
/// Properties:
/// * [signupVerificationHash] 
@BuiltValue()
abstract class SignupResponsePayload implements Built<SignupResponsePayload, SignupResponsePayloadBuilder> {
  @BuiltValueField(wireName: r'signupVerificationHash')
  String get signupVerificationHash;

  SignupResponsePayload._();

  factory SignupResponsePayload([void updates(SignupResponsePayloadBuilder b)]) = _$SignupResponsePayload;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SignupResponsePayloadBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SignupResponsePayload> get serializer => _$SignupResponsePayloadSerializer();
}

class _$SignupResponsePayloadSerializer implements PrimitiveSerializer<SignupResponsePayload> {
  @override
  final Iterable<Type> types = const [SignupResponsePayload, _$SignupResponsePayload];

  @override
  final String wireName = r'SignupResponsePayload';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SignupResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'signupVerificationHash';
    yield serializers.serialize(
      object.signupVerificationHash,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SignupResponsePayload object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SignupResponsePayloadBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'signupVerificationHash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.signupVerificationHash = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SignupResponsePayload deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SignupResponsePayloadBuilder();
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

