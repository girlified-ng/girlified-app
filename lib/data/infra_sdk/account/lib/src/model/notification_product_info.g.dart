// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'notification_product_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationProductInfo extends NotificationProductInfo {
  @override
  final String? id;
  @override
  final String? name;
  @override
  final String? description;
  @override
  final String? price;

  factory _$NotificationProductInfo(
          [void Function(NotificationProductInfoBuilder)? updates]) =>
      (NotificationProductInfoBuilder()..update(updates))._build();

  _$NotificationProductInfo._(
      {this.id, this.name, this.description, this.price})
      : super._();
  @override
  NotificationProductInfo rebuild(
          void Function(NotificationProductInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationProductInfoBuilder toBuilder() =>
      NotificationProductInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationProductInfo &&
        id == other.id &&
        name == other.name &&
        description == other.description &&
        price == other.price;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, price.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationProductInfo')
          ..add('id', id)
          ..add('name', name)
          ..add('description', description)
          ..add('price', price))
        .toString();
  }
}

class NotificationProductInfoBuilder
    implements
        Builder<NotificationProductInfo, NotificationProductInfoBuilder> {
  _$NotificationProductInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  String? _price;
  String? get price => _$this._price;
  set price(String? price) => _$this._price = price;

  NotificationProductInfoBuilder() {
    NotificationProductInfo._defaults(this);
  }

  NotificationProductInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _name = $v.name;
      _description = $v.description;
      _price = $v.price;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationProductInfo other) {
    _$v = other as _$NotificationProductInfo;
  }

  @override
  void update(void Function(NotificationProductInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationProductInfo build() => _build();

  _$NotificationProductInfo _build() {
    final _$result = _$v ??
        _$NotificationProductInfo._(
          id: id,
          name: name,
          description: description,
          price: price,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
