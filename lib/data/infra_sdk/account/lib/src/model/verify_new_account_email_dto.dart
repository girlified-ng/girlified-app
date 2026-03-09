// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'verify_new_account_email_dto.g.dart';

/// VerifyNewAccountEmailDTO
///
/// Properties:
/// * [otp] - Activation token (OTP)
@BuiltValue()
abstract class VerifyNewAccountEmailDTO implements Built<VerifyNewAccountEmailDTO, VerifyNewAccountEmailDTOBuilder> {
  /// Activation token (OTP)
  @BuiltValueField(wireName: r'otp')
  String get otp;

  VerifyNewAccountEmailDTO._();

  factory VerifyNewAccountEmailDTO([void updates(VerifyNewAccountEmailDTOBuilder b)]) = _$VerifyNewAccountEmailDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(VerifyNewAccountEmailDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<VerifyNewAccountEmailDTO> get serializer => _$VerifyNewAccountEmailDTOSerializer();
}

class _$VerifyNewAccountEmailDTOSerializer implements PrimitiveSerializer<VerifyNewAccountEmailDTO> {
  @override
  final Iterable<Type> types = const [VerifyNewAccountEmailDTO, _$VerifyNewAccountEmailDTO];

  @override
  final String wireName = r'VerifyNewAccountEmailDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    VerifyNewAccountEmailDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'otp';
    yield serializers.serialize(
      object.otp,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    VerifyNewAccountEmailDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required VerifyNewAccountEmailDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
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
  VerifyNewAccountEmailDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = VerifyNewAccountEmailDTOBuilder();
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

