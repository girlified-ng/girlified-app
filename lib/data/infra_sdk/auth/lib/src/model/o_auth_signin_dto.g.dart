// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'o_auth_signin_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OAuthSigninDTO extends OAuthSigninDTO {
  @override
  final String email;

  factory _$OAuthSigninDTO([void Function(OAuthSigninDTOBuilder)? updates]) =>
      (OAuthSigninDTOBuilder()..update(updates))._build();

  _$OAuthSigninDTO._({required this.email}) : super._();
  @override
  OAuthSigninDTO rebuild(void Function(OAuthSigninDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OAuthSigninDTOBuilder toBuilder() => OAuthSigninDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OAuthSigninDTO && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OAuthSigninDTO')..add('email', email))
        .toString();
  }
}

class OAuthSigninDTOBuilder
    implements Builder<OAuthSigninDTO, OAuthSigninDTOBuilder> {
  _$OAuthSigninDTO? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  OAuthSigninDTOBuilder() {
    OAuthSigninDTO._defaults(this);
  }

  OAuthSigninDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OAuthSigninDTO other) {
    _$v = other as _$OAuthSigninDTO;
  }

  @override
  void update(void Function(OAuthSigninDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OAuthSigninDTO build() => _build();

  _$OAuthSigninDTO _build() {
    final _$result = _$v ??
        _$OAuthSigninDTO._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'OAuthSigninDTO', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
