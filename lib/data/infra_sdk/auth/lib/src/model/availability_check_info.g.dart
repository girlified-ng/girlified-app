// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'availability_check_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AvailabilityCheckInfo extends AvailabilityCheckInfo {
  @override
  final bool isAvailable;

  factory _$AvailabilityCheckInfo(
          [void Function(AvailabilityCheckInfoBuilder)? updates]) =>
      (AvailabilityCheckInfoBuilder()..update(updates))._build();

  _$AvailabilityCheckInfo._({required this.isAvailable}) : super._();
  @override
  AvailabilityCheckInfo rebuild(
          void Function(AvailabilityCheckInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AvailabilityCheckInfoBuilder toBuilder() =>
      AvailabilityCheckInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailabilityCheckInfo && isAvailable == other.isAvailable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, isAvailable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AvailabilityCheckInfo')
          ..add('isAvailable', isAvailable))
        .toString();
  }
}

class AvailabilityCheckInfoBuilder
    implements Builder<AvailabilityCheckInfo, AvailabilityCheckInfoBuilder> {
  _$AvailabilityCheckInfo? _$v;

  bool? _isAvailable;
  bool? get isAvailable => _$this._isAvailable;
  set isAvailable(bool? isAvailable) => _$this._isAvailable = isAvailable;

  AvailabilityCheckInfoBuilder() {
    AvailabilityCheckInfo._defaults(this);
  }

  AvailabilityCheckInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isAvailable = $v.isAvailable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AvailabilityCheckInfo other) {
    _$v = other as _$AvailabilityCheckInfo;
  }

  @override
  void update(void Function(AvailabilityCheckInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailabilityCheckInfo build() => _build();

  _$AvailabilityCheckInfo _build() {
    final _$result = _$v ??
        _$AvailabilityCheckInfo._(
          isAvailable: BuiltValueNullFieldError.checkNotNull(
              isAvailable, r'AvailabilityCheckInfo', 'isAvailable'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
