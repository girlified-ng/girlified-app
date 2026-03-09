// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'order_sanitary_pad_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderSanitaryPadDTO extends OrderSanitaryPadDTO {
  @override
  final num quantity;
  @override
  final String deliveryMethod;
  @override
  final String buildingNumber;
  @override
  final String address;
  @override
  final String nearestLandmark;

  factory _$OrderSanitaryPadDTO(
          [void Function(OrderSanitaryPadDTOBuilder)? updates]) =>
      (OrderSanitaryPadDTOBuilder()..update(updates))._build();

  _$OrderSanitaryPadDTO._(
      {required this.quantity,
      required this.deliveryMethod,
      required this.buildingNumber,
      required this.address,
      required this.nearestLandmark})
      : super._();
  @override
  OrderSanitaryPadDTO rebuild(
          void Function(OrderSanitaryPadDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderSanitaryPadDTOBuilder toBuilder() =>
      OrderSanitaryPadDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderSanitaryPadDTO &&
        quantity == other.quantity &&
        deliveryMethod == other.deliveryMethod &&
        buildingNumber == other.buildingNumber &&
        address == other.address &&
        nearestLandmark == other.nearestLandmark;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, deliveryMethod.hashCode);
    _$hash = $jc(_$hash, buildingNumber.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, nearestLandmark.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderSanitaryPadDTO')
          ..add('quantity', quantity)
          ..add('deliveryMethod', deliveryMethod)
          ..add('buildingNumber', buildingNumber)
          ..add('address', address)
          ..add('nearestLandmark', nearestLandmark))
        .toString();
  }
}

class OrderSanitaryPadDTOBuilder
    implements Builder<OrderSanitaryPadDTO, OrderSanitaryPadDTOBuilder> {
  _$OrderSanitaryPadDTO? _$v;

  num? _quantity;
  num? get quantity => _$this._quantity;
  set quantity(num? quantity) => _$this._quantity = quantity;

  String? _deliveryMethod;
  String? get deliveryMethod => _$this._deliveryMethod;
  set deliveryMethod(String? deliveryMethod) =>
      _$this._deliveryMethod = deliveryMethod;

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

  OrderSanitaryPadDTOBuilder() {
    OrderSanitaryPadDTO._defaults(this);
  }

  OrderSanitaryPadDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _quantity = $v.quantity;
      _deliveryMethod = $v.deliveryMethod;
      _buildingNumber = $v.buildingNumber;
      _address = $v.address;
      _nearestLandmark = $v.nearestLandmark;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderSanitaryPadDTO other) {
    _$v = other as _$OrderSanitaryPadDTO;
  }

  @override
  void update(void Function(OrderSanitaryPadDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderSanitaryPadDTO build() => _build();

  _$OrderSanitaryPadDTO _build() {
    final _$result = _$v ??
        _$OrderSanitaryPadDTO._(
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'OrderSanitaryPadDTO', 'quantity'),
          deliveryMethod: BuiltValueNullFieldError.checkNotNull(
              deliveryMethod, r'OrderSanitaryPadDTO', 'deliveryMethod'),
          buildingNumber: BuiltValueNullFieldError.checkNotNull(
              buildingNumber, r'OrderSanitaryPadDTO', 'buildingNumber'),
          address: BuiltValueNullFieldError.checkNotNull(
              address, r'OrderSanitaryPadDTO', 'address'),
          nearestLandmark: BuiltValueNullFieldError.checkNotNull(
              nearestLandmark, r'OrderSanitaryPadDTO', 'nearestLandmark'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
