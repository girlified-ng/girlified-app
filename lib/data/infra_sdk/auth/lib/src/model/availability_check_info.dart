// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'availability_check_info.g.dart';

/// AvailabilityCheckInfo
///
/// Properties:
/// * [isAvailable] 
@BuiltValue()
abstract class AvailabilityCheckInfo implements Built<AvailabilityCheckInfo, AvailabilityCheckInfoBuilder> {
  @BuiltValueField(wireName: r'isAvailable')
  bool get isAvailable;

  AvailabilityCheckInfo._();

  factory AvailabilityCheckInfo([void updates(AvailabilityCheckInfoBuilder b)]) = _$AvailabilityCheckInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailabilityCheckInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailabilityCheckInfo> get serializer => _$AvailabilityCheckInfoSerializer();
}

class _$AvailabilityCheckInfoSerializer implements PrimitiveSerializer<AvailabilityCheckInfo> {
  @override
  final Iterable<Type> types = const [AvailabilityCheckInfo, _$AvailabilityCheckInfo];

  @override
  final String wireName = r'AvailabilityCheckInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailabilityCheckInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'isAvailable';
    yield serializers.serialize(
      object.isAvailable,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AvailabilityCheckInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AvailabilityCheckInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'isAvailable':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isAvailable = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AvailabilityCheckInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailabilityCheckInfoBuilder();
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

