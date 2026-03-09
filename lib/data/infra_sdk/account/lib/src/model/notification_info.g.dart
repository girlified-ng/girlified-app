// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'notification_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationInfo extends NotificationInfo {
  @override
  final String id;
  @override
  final String title;
  @override
  final String message;
  @override
  final bool isRead;
  @override
  final DateTime createdAt;
  @override
  final NotificationProductInfo? product;

  factory _$NotificationInfo(
          [void Function(NotificationInfoBuilder)? updates]) =>
      (NotificationInfoBuilder()..update(updates))._build();

  _$NotificationInfo._(
      {required this.id,
      required this.title,
      required this.message,
      required this.isRead,
      required this.createdAt,
      this.product})
      : super._();
  @override
  NotificationInfo rebuild(void Function(NotificationInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationInfoBuilder toBuilder() =>
      NotificationInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationInfo &&
        id == other.id &&
        title == other.title &&
        message == other.message &&
        isRead == other.isRead &&
        createdAt == other.createdAt &&
        product == other.product;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, product.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationInfo')
          ..add('id', id)
          ..add('title', title)
          ..add('message', message)
          ..add('isRead', isRead)
          ..add('createdAt', createdAt)
          ..add('product', product))
        .toString();
  }
}

class NotificationInfoBuilder
    implements Builder<NotificationInfo, NotificationInfoBuilder> {
  _$NotificationInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  NotificationProductInfoBuilder? _product;
  NotificationProductInfoBuilder get product =>
      _$this._product ??= NotificationProductInfoBuilder();
  set product(NotificationProductInfoBuilder? product) =>
      _$this._product = product;

  NotificationInfoBuilder() {
    NotificationInfo._defaults(this);
  }

  NotificationInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _title = $v.title;
      _message = $v.message;
      _isRead = $v.isRead;
      _createdAt = $v.createdAt;
      _product = $v.product?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationInfo other) {
    _$v = other as _$NotificationInfo;
  }

  @override
  void update(void Function(NotificationInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationInfo build() => _build();

  _$NotificationInfo _build() {
    _$NotificationInfo _$result;
    try {
      _$result = _$v ??
          _$NotificationInfo._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'NotificationInfo', 'id'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'NotificationInfo', 'title'),
            message: BuiltValueNullFieldError.checkNotNull(
                message, r'NotificationInfo', 'message'),
            isRead: BuiltValueNullFieldError.checkNotNull(
                isRead, r'NotificationInfo', 'isRead'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'NotificationInfo', 'createdAt'),
            product: _product?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'product';
        _product?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NotificationInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
