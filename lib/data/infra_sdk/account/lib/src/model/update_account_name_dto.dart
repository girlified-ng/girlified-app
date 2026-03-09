// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_account_name_dto.g.dart';

/// UpdateAccountNameDTO
///
/// Properties:
/// * [firstName] - New account first name.
/// * [lastName] - New account last name.
@BuiltValue()
abstract class UpdateAccountNameDTO implements Built<UpdateAccountNameDTO, UpdateAccountNameDTOBuilder> {
  /// New account first name.
  @BuiltValueField(wireName: r'firstName')
  String get firstName;

  /// New account last name.
  @BuiltValueField(wireName: r'lastName')
  String get lastName;

  UpdateAccountNameDTO._();

  factory UpdateAccountNameDTO([void updates(UpdateAccountNameDTOBuilder b)]) = _$UpdateAccountNameDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAccountNameDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAccountNameDTO> get serializer => _$UpdateAccountNameDTOSerializer();
}

class _$UpdateAccountNameDTOSerializer implements PrimitiveSerializer<UpdateAccountNameDTO> {
  @override
  final Iterable<Type> types = const [UpdateAccountNameDTO, _$UpdateAccountNameDTO];

  @override
  final String wireName = r'UpdateAccountNameDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAccountNameDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'firstName';
    yield serializers.serialize(
      object.firstName,
      specifiedType: const FullType(String),
    );
    yield r'lastName';
    yield serializers.serialize(
      object.lastName,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAccountNameDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAccountNameDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastName = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAccountNameDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAccountNameDTOBuilder();
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

