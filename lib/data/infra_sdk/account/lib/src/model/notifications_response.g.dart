// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'notifications_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NotificationsResponse extends NotificationsResponse {
  @override
  final BuiltList<NotificationInfo> notifications;
  @override
  final num totalPages;
  @override
  final bool hasNextPage;

  factory _$NotificationsResponse(
          [void Function(NotificationsResponseBuilder)? updates]) =>
      (NotificationsResponseBuilder()..update(updates))._build();

  _$NotificationsResponse._(
      {required this.notifications,
      required this.totalPages,
      required this.hasNextPage})
      : super._();
  @override
  NotificationsResponse rebuild(
          void Function(NotificationsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NotificationsResponseBuilder toBuilder() =>
      NotificationsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NotificationsResponse &&
        notifications == other.notifications &&
        totalPages == other.totalPages &&
        hasNextPage == other.hasNextPage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, hasNextPage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NotificationsResponse')
          ..add('notifications', notifications)
          ..add('totalPages', totalPages)
          ..add('hasNextPage', hasNextPage))
        .toString();
  }
}

class NotificationsResponseBuilder
    implements Builder<NotificationsResponse, NotificationsResponseBuilder> {
  _$NotificationsResponse? _$v;

  ListBuilder<NotificationInfo>? _notifications;
  ListBuilder<NotificationInfo> get notifications =>
      _$this._notifications ??= ListBuilder<NotificationInfo>();
  set notifications(ListBuilder<NotificationInfo>? notifications) =>
      _$this._notifications = notifications;

  num? _totalPages;
  num? get totalPages => _$this._totalPages;
  set totalPages(num? totalPages) => _$this._totalPages = totalPages;

  bool? _hasNextPage;
  bool? get hasNextPage => _$this._hasNextPage;
  set hasNextPage(bool? hasNextPage) => _$this._hasNextPage = hasNextPage;

  NotificationsResponseBuilder() {
    NotificationsResponse._defaults(this);
  }

  NotificationsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _notifications = $v.notifications.toBuilder();
      _totalPages = $v.totalPages;
      _hasNextPage = $v.hasNextPage;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NotificationsResponse other) {
    _$v = other as _$NotificationsResponse;
  }

  @override
  void update(void Function(NotificationsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NotificationsResponse build() => _build();

  _$NotificationsResponse _build() {
    _$NotificationsResponse _$result;
    try {
      _$result = _$v ??
          _$NotificationsResponse._(
            notifications: notifications.build(),
            totalPages: BuiltValueNullFieldError.checkNotNull(
                totalPages, r'NotificationsResponse', 'totalPages'),
            hasNextPage: BuiltValueNullFieldError.checkNotNull(
                hasNextPage, r'NotificationsResponse', 'hasNextPage'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        notifications.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'NotificationsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
