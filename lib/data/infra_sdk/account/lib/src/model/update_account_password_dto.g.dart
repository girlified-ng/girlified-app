// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_account_password_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAccountPasswordDTO extends UpdateAccountPasswordDTO {
  @override
  final String currentPassword;
  @override
  final String newPassword;

  factory _$UpdateAccountPasswordDTO(
          [void Function(UpdateAccountPasswordDTOBuilder)? updates]) =>
      (UpdateAccountPasswordDTOBuilder()..update(updates))._build();

  _$UpdateAccountPasswordDTO._(
      {required this.currentPassword, required this.newPassword})
      : super._();
  @override
  UpdateAccountPasswordDTO rebuild(
          void Function(UpdateAccountPasswordDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAccountPasswordDTOBuilder toBuilder() =>
      UpdateAccountPasswordDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAccountPasswordDTO &&
        currentPassword == other.currentPassword &&
        newPassword == other.newPassword;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, currentPassword.hashCode);
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAccountPasswordDTO')
          ..add('currentPassword', currentPassword)
          ..add('newPassword', newPassword))
        .toString();
  }
}

class UpdateAccountPasswordDTOBuilder
    implements
        Builder<UpdateAccountPasswordDTO, UpdateAccountPasswordDTOBuilder> {
  _$UpdateAccountPasswordDTO? _$v;

  String? _currentPassword;
  String? get currentPassword => _$this._currentPassword;
  set currentPassword(String? currentPassword) =>
      _$this._currentPassword = currentPassword;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  UpdateAccountPasswordDTOBuilder() {
    UpdateAccountPasswordDTO._defaults(this);
  }

  UpdateAccountPasswordDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _currentPassword = $v.currentPassword;
      _newPassword = $v.newPassword;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAccountPasswordDTO other) {
    _$v = other as _$UpdateAccountPasswordDTO;
  }

  @override
  void update(void Function(UpdateAccountPasswordDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAccountPasswordDTO build() => _build();

  _$UpdateAccountPasswordDTO _build() {
    final _$result = _$v ??
        _$UpdateAccountPasswordDTO._(
          currentPassword: BuiltValueNullFieldError.checkNotNull(
              currentPassword, r'UpdateAccountPasswordDTO', 'currentPassword'),
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'UpdateAccountPasswordDTO', 'newPassword'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
