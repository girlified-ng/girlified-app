// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_account_phone_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAccountPhoneDTO extends UpdateAccountPhoneDTO {
  @override
  final String newPhone;
  @override
  final String password;

  factory _$UpdateAccountPhoneDTO(
          [void Function(UpdateAccountPhoneDTOBuilder)? updates]) =>
      (UpdateAccountPhoneDTOBuilder()..update(updates))._build();

  _$UpdateAccountPhoneDTO._({required this.newPhone, required this.password})
      : super._();
  @override
  UpdateAccountPhoneDTO rebuild(
          void Function(UpdateAccountPhoneDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAccountPhoneDTOBuilder toBuilder() =>
      UpdateAccountPhoneDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAccountPhoneDTO &&
        newPhone == other.newPhone &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPhone.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAccountPhoneDTO')
          ..add('newPhone', newPhone)
          ..add('password', password))
        .toString();
  }
}

class UpdateAccountPhoneDTOBuilder
    implements Builder<UpdateAccountPhoneDTO, UpdateAccountPhoneDTOBuilder> {
  _$UpdateAccountPhoneDTO? _$v;

  String? _newPhone;
  String? get newPhone => _$this._newPhone;
  set newPhone(String? newPhone) => _$this._newPhone = newPhone;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  UpdateAccountPhoneDTOBuilder() {
    UpdateAccountPhoneDTO._defaults(this);
  }

  UpdateAccountPhoneDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPhone = $v.newPhone;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAccountPhoneDTO other) {
    _$v = other as _$UpdateAccountPhoneDTO;
  }

  @override
  void update(void Function(UpdateAccountPhoneDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAccountPhoneDTO build() => _build();

  _$UpdateAccountPhoneDTO _build() {
    final _$result = _$v ??
        _$UpdateAccountPhoneDTO._(
          newPhone: BuiltValueNullFieldError.checkNotNull(
              newPhone, r'UpdateAccountPhoneDTO', 'newPhone'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'UpdateAccountPhoneDTO', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
