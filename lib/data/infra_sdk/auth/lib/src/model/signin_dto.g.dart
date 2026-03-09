// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'signin_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SigninDTO extends SigninDTO {
  @override
  final String email;
  @override
  final String password;

  factory _$SigninDTO([void Function(SigninDTOBuilder)? updates]) =>
      (SigninDTOBuilder()..update(updates))._build();

  _$SigninDTO._({required this.email, required this.password}) : super._();
  @override
  SigninDTO rebuild(void Function(SigninDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SigninDTOBuilder toBuilder() => SigninDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SigninDTO &&
        email == other.email &&
        password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SigninDTO')
          ..add('email', email)
          ..add('password', password))
        .toString();
  }
}

class SigninDTOBuilder implements Builder<SigninDTO, SigninDTOBuilder> {
  _$SigninDTO? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  SigninDTOBuilder() {
    SigninDTO._defaults(this);
  }

  SigninDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SigninDTO other) {
    _$v = other as _$SigninDTO;
  }

  @override
  void update(void Function(SigninDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SigninDTO build() => _build();

  _$SigninDTO _build() {
    final _$result = _$v ??
        _$SigninDTO._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'SigninDTO', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'SigninDTO', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
