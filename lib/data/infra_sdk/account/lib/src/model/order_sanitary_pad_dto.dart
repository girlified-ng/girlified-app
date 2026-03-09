// @dart=3.5
// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_sanitary_pad_dto.g.dart';

/// OrderSanitaryPadDTO
///
/// Properties:
/// * [quantity] - Quantity
/// * [deliveryMethod] - Delivery method.
/// * [buildingNumber] - Building number.
/// * [address] - Address.
/// * [nearestLandmark] - Nearest landmark.
@BuiltValue()
abstract class OrderSanitaryPadDTO implements Built<OrderSanitaryPadDTO, OrderSanitaryPadDTOBuilder> {
  /// Quantity
  @BuiltValueField(wireName: r'quantity')
  num get quantity;

  /// Delivery method.
  @BuiltValueField(wireName: r'deliveryMethod')
  String get deliveryMethod;

  /// Building number.
  @BuiltValueField(wireName: r'buildingNumber')
  String get buildingNumber;

  /// Address.
  @BuiltValueField(wireName: r'address')
  String get address;

  /// Nearest landmark.
  @BuiltValueField(wireName: r'nearestLandmark')
  String get nearestLandmark;

  OrderSanitaryPadDTO._();

  factory OrderSanitaryPadDTO([void updates(OrderSanitaryPadDTOBuilder b)]) = _$OrderSanitaryPadDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderSanitaryPadDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderSanitaryPadDTO> get serializer => _$OrderSanitaryPadDTOSerializer();
}

class _$OrderSanitaryPadDTOSerializer implements PrimitiveSerializer<OrderSanitaryPadDTO> {
  @override
  final Iterable<Type> types = const [OrderSanitaryPadDTO, _$OrderSanitaryPadDTO];

  @override
  final String wireName = r'OrderSanitaryPadDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderSanitaryPadDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(num),
    );
    yield r'deliveryMethod';
    yield serializers.serialize(
      object.deliveryMethod,
      specifiedType: const FullType(String),
    );
    yield r'buildingNumber';
    yield serializers.serialize(
      object.buildingNumber,
      specifiedType: const FullType(String),
    );
    yield r'address';
    yield serializers.serialize(
      object.address,
      specifiedType: const FullType(String),
    );
    yield r'nearestLandmark';
    yield serializers.serialize(
      object.nearestLandmark,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderSanitaryPadDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderSanitaryPadDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.quantity = valueDes;
          break;
        case r'deliveryMethod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.deliveryMethod = valueDes;
          break;
        case r'buildingNumber':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.buildingNumber = valueDes;
          break;
        case r'address':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.address = valueDes;
          break;
        case r'nearestLandmark':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.nearestLandmark = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderSanitaryPadDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderSanitaryPadDTOBuilder();
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

