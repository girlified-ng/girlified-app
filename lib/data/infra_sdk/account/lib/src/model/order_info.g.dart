// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'order_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderInfoDeliveryMethodEnum _$orderInfoDeliveryMethodEnum_delivery =
    const OrderInfoDeliveryMethodEnum._('delivery');
const OrderInfoDeliveryMethodEnum _$orderInfoDeliveryMethodEnum_pickup =
    const OrderInfoDeliveryMethodEnum._('pickup');

OrderInfoDeliveryMethodEnum _$orderInfoDeliveryMethodEnumValueOf(String name) {
  switch (name) {
    case 'delivery':
      return _$orderInfoDeliveryMethodEnum_delivery;
    case 'pickup':
      return _$orderInfoDeliveryMethodEnum_pickup;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderInfoDeliveryMethodEnum>
    _$orderInfoDeliveryMethodEnumValues =
    BuiltSet<OrderInfoDeliveryMethodEnum>(const <OrderInfoDeliveryMethodEnum>[
  _$orderInfoDeliveryMethodEnum_delivery,
  _$orderInfoDeliveryMethodEnum_pickup,
]);

Serializer<OrderInfoDeliveryMethodEnum>
    _$orderInfoDeliveryMethodEnumSerializer =
    _$OrderInfoDeliveryMethodEnumSerializer();

class _$OrderInfoDeliveryMethodEnumSerializer
    implements PrimitiveSerializer<OrderInfoDeliveryMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'delivery': 'Delivery',
    'pickup': 'Pickup',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Delivery': 'delivery',
    'Pickup': 'pickup',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderInfoDeliveryMethodEnum];
  @override
  final String wireName = 'OrderInfoDeliveryMethodEnum';

  @override
  Object serialize(Serializers serializers, OrderInfoDeliveryMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderInfoDeliveryMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderInfoDeliveryMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderInfo extends OrderInfo {
  @override
  final String id;
  @override
  final String orderId;
  @override
  final num quantity;
  @override
  final OrderInfoDeliveryMethodEnum deliveryMethod;
  @override
  final bool isCompleted;
  @override
  final String buildingNumber;
  @override
  final String address;
  @override
  final String nearestLandmark;

  factory _$OrderInfo([void Function(OrderInfoBuilder)? updates]) =>
      (OrderInfoBuilder()..update(updates))._build();

  _$OrderInfo._(
      {required this.id,
      required this.orderId,
      required this.quantity,
      required this.deliveryMethod,
      required this.isCompleted,
      required this.buildingNumber,
      required this.address,
      required this.nearestLandmark})
      : super._();
  @override
  OrderInfo rebuild(void Function(OrderInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderInfoBuilder toBuilder() => OrderInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderInfo &&
        id == other.id &&
        orderId == other.orderId &&
        quantity == other.quantity &&
        deliveryMethod == other.deliveryMethod &&
        isCompleted == other.isCompleted &&
        buildingNumber == other.buildingNumber &&
        address == other.address &&
        nearestLandmark == other.nearestLandmark;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, deliveryMethod.hashCode);
    _$hash = $jc(_$hash, isCompleted.hashCode);
    _$hash = $jc(_$hash, buildingNumber.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, nearestLandmark.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderInfo')
          ..add('id', id)
          ..add('orderId', orderId)
          ..add('quantity', quantity)
          ..add('deliveryMethod', deliveryMethod)
          ..add('isCompleted', isCompleted)
          ..add('buildingNumber', buildingNumber)
          ..add('address', address)
          ..add('nearestLandmark', nearestLandmark))
        .toString();
  }
}

class OrderInfoBuilder implements Builder<OrderInfo, OrderInfoBuilder> {
  _$OrderInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  num? _quantity;
  num? get quantity => _$this._quantity;
  set quantity(num? quantity) => _$this._quantity = quantity;

  OrderInfoDeliveryMethodEnum? _deliveryMethod;
  OrderInfoDeliveryMethodEnum? get deliveryMethod => _$this._deliveryMethod;
  set deliveryMethod(OrderInfoDeliveryMethodEnum? deliveryMethod) =>
      _$this._deliveryMethod = deliveryMethod;

  bool? _isCompleted;
  bool? get isCompleted => _$this._isCompleted;
  set isCompleted(bool? isCompleted) => _$this._isCompleted = isCompleted;

  String? _buildingNumber;
  String? get buildingNumber => _$this._buildingNumber;
  set buildingNumber(String? buildingNumber) =>
      _$this._buildingNumber = buildingNumber;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _nearestLandmark;
  String? get nearestLandmark => _$this._nearestLandmark;
  set nearestLandmark(String? nearestLandmark) =>
      _$this._nearestLandmark = nearestLandmark;

  OrderInfoBuilder() {
    OrderInfo._defaults(this);
  }

  OrderInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _orderId = $v.orderId;
      _quantity = $v.quantity;
      _deliveryMethod = $v.deliveryMethod;
      _isCompleted = $v.isCompleted;
      _buildingNumber = $v.buildingNumber;
      _address = $v.address;
      _nearestLandmark = $v.nearestLandmark;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderInfo other) {
    _$v = other as _$OrderInfo;
  }

  @override
  void update(void Function(OrderInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderInfo build() => _build();

  _$OrderInfo _build() {
    final _$result = _$v ??
        _$OrderInfo._(
          id: BuiltValueNullFieldError.checkNotNull(id, r'OrderInfo', 'id'),
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'OrderInfo', 'orderId'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'OrderInfo', 'quantity'),
          deliveryMethod: BuiltValueNullFieldError.checkNotNull(
              deliveryMethod, r'OrderInfo', 'deliveryMethod'),
          isCompleted: BuiltValueNullFieldError.checkNotNull(
              isCompleted, r'OrderInfo', 'isCompleted'),
          buildingNumber: BuiltValueNullFieldError.checkNotNull(
              buildingNumber, r'OrderInfo', 'buildingNumber'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'OrderInfo', 'address'),
          nearestLandmark: BuiltValueNullFieldError.checkNotNull(
              nearestLandmark, r'OrderInfo', 'nearestLandmark'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
