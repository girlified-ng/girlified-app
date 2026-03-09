// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_account_location_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAccountLocationDTO extends UpdateAccountLocationDTO {
  @override
  final String state;
  @override
  final String city;

  factory _$UpdateAccountLocationDTO(
          [void Function(UpdateAccountLocationDTOBuilder)? updates]) =>
      (UpdateAccountLocationDTOBuilder()..update(updates))._build();

  _$UpdateAccountLocationDTO._({required this.state, required this.city})
      : super._();
  @override
  UpdateAccountLocationDTO rebuild(
          void Function(UpdateAccountLocationDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAccountLocationDTOBuilder toBuilder() =>
      UpdateAccountLocationDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAccountLocationDTO &&
        state == other.state &&
        city == other.city;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, state.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAccountLocationDTO')
          ..add('state', state)
          ..add('city', city))
        .toString();
  }
}

class UpdateAccountLocationDTOBuilder
    implements
        Builder<UpdateAccountLocationDTO, UpdateAccountLocationDTOBuilder> {
  _$UpdateAccountLocationDTO? _$v;

  String? _state;
  String? get state => _$this._state;
  set state(String? state) => _$this._state = state;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  UpdateAccountLocationDTOBuilder() {
    UpdateAccountLocationDTO._defaults(this);
  }

  UpdateAccountLocationDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _state = $v.state;
      _city = $v.city;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAccountLocationDTO other) {
    _$v = other as _$UpdateAccountLocationDTO;
  }

  @override
  void update(void Function(UpdateAccountLocationDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAccountLocationDTO build() => _build();

  _$UpdateAccountLocationDTO _build() {
    final _$result = _$v ??
        _$UpdateAccountLocationDTO._(
          state: BuiltValueNullFieldError.checkNotNull(
              state, r'UpdateAccountLocationDTO', 'state'),
          city: BuiltValueNullFieldError.checkNotNull(
              city, r'UpdateAccountLocationDTO', 'city'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
