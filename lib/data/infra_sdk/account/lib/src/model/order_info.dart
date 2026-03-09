// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_info.g.dart';

/// OrderInfo
///
/// Properties:
/// * [id] - Order ID (Auto generated).
/// * [orderId] - Order ID (Custom generated).
/// * [quantity] - Order quantity e.g 1
/// * [deliveryMethod] - Order delivery method e.g PickUp.
/// * [isCompleted] - Order completed status e.g false.
/// * [buildingNumber] - Order building number e.g 123.
/// * [address] - Order address e.g 123 Main St, Anytown, USA.
/// * [nearestLandmark] - Order nearest landmark e.g 123 Main St, Anytown, USA.
@BuiltValue()
abstract class OrderInfo implements Built<OrderInfo, OrderInfoBuilder> {
  /// Order ID (Auto generated).
  @BuiltValueField(wireName: r'id')
  String get id;

  /// Order ID (Custom generated).
  @BuiltValueField(wireName: r'orderId')
  String get orderId;

  /// Order quantity e.g 1
  @BuiltValueField(wireName: r'quantity')
  num get quantity;

  /// Order delivery method e.g PickUp.
  @BuiltValueField(wireName: r'deliveryMethod')
  OrderInfoDeliveryMethodEnum get deliveryMethod;
  // enum deliveryMethodEnum {  Delivery,  Pickup,  };

  /// Order completed status e.g false.
  @BuiltValueField(wireName: r'isCompleted')
  bool get isCompleted;

  /// Order building number e.g 123.
  @BuiltValueField(wireName: r'buildingNumber')
  String get buildingNumber;

  /// Order address e.g 123 Main St, Anytown, USA.
  @BuiltValueField(wireName: r'address')
  String get address;

  /// Order nearest landmark e.g 123 Main St, Anytown, USA.
  @BuiltValueField(wireName: r'nearestLandmark')
  String get nearestLandmark;

  OrderInfo._();

  factory OrderInfo([void updates(OrderInfoBuilder b)]) = _$OrderInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderInfo> get serializer => _$OrderInfoSerializer();
}

class _$OrderInfoSerializer implements PrimitiveSerializer<OrderInfo> {
  @override
  final Iterable<Type> types = const [OrderInfo, _$OrderInfo];

  @override
  final String wireName = r'OrderInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'orderId';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'quantity';
    yield serializers.serialize(
      object.quantity,
      specifiedType: const FullType(num),
    );
    yield r'deliveryMethod';
    yield serializers.serialize(
      object.deliveryMethod,
      specifiedType: const FullType(OrderInfoDeliveryMethodEnum),
    );
    yield r'isCompleted';
    yield serializers.serialize(
      object.isCompleted,
      specifiedType: const FullType(bool),
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
    OrderInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'orderId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
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
            specifiedType: const FullType(OrderInfoDeliveryMethodEnum),
          ) as OrderInfoDeliveryMethodEnum;
          result.deliveryMethod = valueDes;
          break;
        case r'isCompleted':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isCompleted = valueDes;
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
  OrderInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderInfoBuilder();
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

class OrderInfoDeliveryMethodEnum extends EnumClass {

  /// Order delivery method e.g PickUp.
  @BuiltValueEnumConst(wireName: r'Delivery')
  static const OrderInfoDeliveryMethodEnum delivery = _$orderInfoDeliveryMethodEnum_delivery;
  /// Order delivery method e.g PickUp.
  @BuiltValueEnumConst(wireName: r'Pickup')
  static const OrderInfoDeliveryMethodEnum pickup = _$orderInfoDeliveryMethodEnum_pickup;

  static Serializer<OrderInfoDeliveryMethodEnum> get serializer => _$orderInfoDeliveryMethodEnumSerializer;

  const OrderInfoDeliveryMethodEnum._(String name): super(name);

  static BuiltSet<OrderInfoDeliveryMethodEnum> get values => _$orderInfoDeliveryMethodEnumValues;
  static OrderInfoDeliveryMethodEnum valueOf(String name) => _$orderInfoDeliveryMethodEnumValueOf(name);
}

