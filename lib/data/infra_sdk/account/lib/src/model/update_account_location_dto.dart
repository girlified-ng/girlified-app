// @dart=3.5
// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_account_location_dto.g.dart';

/// UpdateAccountLocationDTO
///
/// Properties:
/// * [state] - User state.
/// * [city] - User city.
@BuiltValue()
abstract class UpdateAccountLocationDTO implements Built<UpdateAccountLocationDTO, UpdateAccountLocationDTOBuilder> {
  /// User state.
  @BuiltValueField(wireName: r'state')
  String get state;

  /// User city.
  @BuiltValueField(wireName: r'city')
  String get city;

  UpdateAccountLocationDTO._();

  factory UpdateAccountLocationDTO([void updates(UpdateAccountLocationDTOBuilder b)]) = _$UpdateAccountLocationDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateAccountLocationDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateAccountLocationDTO> get serializer => _$UpdateAccountLocationDTOSerializer();
}

class _$UpdateAccountLocationDTOSerializer implements PrimitiveSerializer<UpdateAccountLocationDTO> {
  @override
  final Iterable<Type> types = const [UpdateAccountLocationDTO, _$UpdateAccountLocationDTO];

  @override
  final String wireName = r'UpdateAccountLocationDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateAccountLocationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
    yield r'city';
    yield serializers.serialize(
      object.city,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateAccountLocationDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateAccountLocationDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        case r'city':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.city = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateAccountLocationDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateAccountLocationDTOBuilder();
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

