// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'reset_password_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordDTO extends ResetPasswordDTO {
  @override
  final String newPassword;
  @override
  final String passwordResetToken;
  @override
  final String accountId;

  factory _$ResetPasswordDTO(
          [void Function(ResetPasswordDTOBuilder)? updates]) =>
      (ResetPasswordDTOBuilder()..update(updates))._build();

  _$ResetPasswordDTO._(
      {required this.newPassword,
      required this.passwordResetToken,
      required this.accountId})
      : super._();
  @override
  ResetPasswordDTO rebuild(void Function(ResetPasswordDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordDTOBuilder toBuilder() =>
      ResetPasswordDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordDTO &&
        newPassword == other.newPassword &&
        passwordResetToken == other.passwordResetToken &&
        accountId == other.accountId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newPassword.hashCode);
    _$hash = $jc(_$hash, passwordResetToken.hashCode);
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPasswordDTO')
          ..add('newPassword', newPassword)
          ..add('passwordResetToken', passwordResetToken)
          ..add('accountId', accountId))
        .toString();
  }
}

class ResetPasswordDTOBuilder
    implements Builder<ResetPasswordDTO, ResetPasswordDTOBuilder> {
  _$ResetPasswordDTO? _$v;

  String? _newPassword;
  String? get newPassword => _$this._newPassword;
  set newPassword(String? newPassword) => _$this._newPassword = newPassword;

  String? _passwordResetToken;
  String? get passwordResetToken => _$this._passwordResetToken;
  set passwordResetToken(String? passwordResetToken) =>
      _$this._passwordResetToken = passwordResetToken;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  ResetPasswordDTOBuilder() {
    ResetPasswordDTO._defaults(this);
  }

  ResetPasswordDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newPassword = $v.newPassword;
      _passwordResetToken = $v.passwordResetToken;
      _accountId = $v.accountId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordDTO other) {
    _$v = other as _$ResetPasswordDTO;
  }

  @override
  void update(void Function(ResetPasswordDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordDTO build() => _build();

  _$ResetPasswordDTO _build() {
    final _$result = _$v ??
        _$ResetPasswordDTO._(
          newPassword: BuiltValueNullFieldError.checkNotNull(
              newPassword, r'ResetPasswordDTO', 'newPassword'),
          passwordResetToken: BuiltValueNullFieldError.checkNotNull(
              passwordResetToken, r'ResetPasswordDTO', 'passwordResetToken'),
          accountId: BuiltValueNullFieldError.checkNotNull(
              accountId, r'ResetPasswordDTO', 'accountId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
