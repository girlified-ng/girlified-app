// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_account_phone_dto.g.dart';

/// UpdateAccountPhoneDTO
///
/// Properties:
/// * [newPhone] - New account phone.
/// * [password] - Account password.
@BuiltValue()
abstract class UpdateAccountPhoneDTO implements Built<UpdateAccountPhoneDTO, UpdateAccountPhoneDTOBuilder> {
  /// New account phone.
  @BuiltValueField(wireName: r'newPhone')
  String get newPhone;

  /// Account password.
  @BuiltValueField(wireName: r'password')
  String get password;

  UpdateAccountPhoneDTO._();

  factory UpdateAccountPhoneDTO([void updates(UpdateAccountPhoneDTOBuilder b)]) = _$UpdateAccountPhoneDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAccountPhoneDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAccountPhoneDTO> get serializer => _$UpdateAccountPhoneDTOSerializer();
}

class _$UpdateAccountPhoneDTOSerializer implements PrimitiveSerializer<UpdateAccountPhoneDTO> {
  @override
  final Iterable<Type> types = const [UpdateAccountPhoneDTO, _$UpdateAccountPhoneDTO];

  @override
  final String wireName = r'UpdateAccountPhoneDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAccountPhoneDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newPhone';
    yield serializers.serialize(
      object.newPhone,
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
    UpdateAccountPhoneDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAccountPhoneDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newPhone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newPhone = valueDes;
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
  UpdateAccountPhoneDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAccountPhoneDTOBuilder();
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

