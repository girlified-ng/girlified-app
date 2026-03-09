// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'order_history_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderHistoryResponse extends OrderHistoryResponse {
  @override
  final BuiltList<OrderInfo> orders;
  @override
  final num totalPages;
  @override
  final bool hasNext;

  factory _$OrderHistoryResponse(
          [void Function(OrderHistoryResponseBuilder)? updates]) =>
      (OrderHistoryResponseBuilder()..update(updates))._build();

  _$OrderHistoryResponse._(
      {required this.orders, required this.totalPages, required this.hasNext})
      : super._();
  @override
  OrderHistoryResponse rebuild(
          void Function(OrderHistoryResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderHistoryResponseBuilder toBuilder() =>
      OrderHistoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderHistoryResponse &&
        orders == other.orders &&
        totalPages == other.totalPages &&
        hasNext == other.hasNext;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orders.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, hasNext.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderHistoryResponse')
          ..add('orders', orders)
          ..add('totalPages', totalPages)
          ..add('hasNext', hasNext))
        .toString();
  }
}

class OrderHistoryResponseBuilder
    implements Builder<OrderHistoryResponse, OrderHistoryResponseBuilder> {
  _$OrderHistoryResponse? _$v;

  ListBuilder<OrderInfo>? _orders;
  ListBuilder<OrderInfo> get orders =>
      _$this._orders ??= ListBuilder<OrderInfo>();
  set orders(ListBuilder<OrderInfo>? orders) => _$this._orders = orders;

  num? _totalPages;
  num? get totalPages => _$this._totalPages;
  set totalPages(num? totalPages) => _$this._totalPages = totalPages;

  bool? _hasNext;
  bool? get hasNext => _$this._hasNext;
  set hasNext(bool? hasNext) => _$this._hasNext = hasNext;

  OrderHistoryResponseBuilder() {
    OrderHistoryResponse._defaults(this);
  }

  OrderHistoryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orders = $v.orders.toBuilder();
      _totalPages = $v.totalPages;
      _hasNext = $v.hasNext;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderHistoryResponse other) {
    _$v = other as _$OrderHistoryResponse;
  }

  @override
  void update(void Function(OrderHistoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderHistoryResponse build() => _build();

  _$OrderHistoryResponse _build() {
    _$OrderHistoryResponse _$result;
    try {
      _$result = _$v ??
          _$OrderHistoryResponse._(
            orders: orders.build(),
            totalPages: BuiltValueNullFieldError.checkNotNull(
                totalPages, r'OrderHistoryResponse', 'totalPages'),
            hasNext: BuiltValueNullFieldError.checkNotNull(
                hasNext, r'OrderHistoryResponse', 'hasNext'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'orders';
        orders.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'OrderHistoryResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
