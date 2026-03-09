// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_account_email_dto.g.dart';

/// UpdateAccountEmailDTO
///
/// Properties:
/// * [newEmail] - New account email.
@BuiltValue()
abstract class UpdateAccountEmailDTO implements Built<UpdateAccountEmailDTO, UpdateAccountEmailDTOBuilder> {
  /// New account email.
  @BuiltValueField(wireName: r'newEmail')
  String get newEmail;

  UpdateAccountEmailDTO._();

  factory UpdateAccountEmailDTO([void updates(UpdateAccountEmailDTOBuilder b)]) = _$UpdateAccountEmailDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAccountEmailDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAccountEmailDTO> get serializer => _$UpdateAccountEmailDTOSerializer();
}

class _$UpdateAccountEmailDTOSerializer implements PrimitiveSerializer<UpdateAccountEmailDTO> {
  @override
  final Iterable<Type> types = const [UpdateAccountEmailDTO, _$UpdateAccountEmailDTO];

  @override
  final String wireName = r'UpdateAccountEmailDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAccountEmailDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'newEmail';
    yield serializers.serialize(
      object.newEmail,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAccountEmailDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAccountEmailDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'newEmail':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.newEmail = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAccountEmailDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAccountEmailDTOBuilder();
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

