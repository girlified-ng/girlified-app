// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'complete_signup_verification_dto.g.dart';

/// CompleteSignupVerificationDTO
///
/// Properties:
/// * [signupVerificationHash] 
/// * [otp] 
@BuiltValue()
abstract class CompleteSignupVerificationDTO implements Built<CompleteSignupVerificationDTO, CompleteSignupVerificationDTOBuilder> {
  @BuiltValueField(wireName: r'signupVerificationHash')
  String get signupVerificationHash;

  @BuiltValueField(wireName: r'otp')
  String get otp;

  CompleteSignupVerificationDTO._();

  factory CompleteSignupVerificationDTO([void updates(CompleteSignupVerificationDTOBuilder b)]) = _$CompleteSignupVerificationDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CompleteSignupVerificationDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CompleteSignupVerificationDTO> get serializer => _$CompleteSignupVerificationDTOSerializer();
}

class _$CompleteSignupVerificationDTOSerializer implements PrimitiveSerializer<CompleteSignupVerificationDTO> {
  @override
  final Iterable<Type> types = const [CompleteSignupVerificationDTO, _$CompleteSignupVerificationDTO];

  @override
  final String wireName = r'CompleteSignupVerificationDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CompleteSignupVerificationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'signupVerificationHash';
    yield serializers.serialize(
      object.signupVerificationHash,
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
    CompleteSignupVerificationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CompleteSignupVerificationDTOBuilder result,
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
  CompleteSignupVerificationDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CompleteSignupVerificationDTOBuilder();
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

