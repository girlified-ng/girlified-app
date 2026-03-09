// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'forgot_password_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ForgotPasswordDTO extends ForgotPasswordDTO {
  @override
  final String email;

  factory _$ForgotPasswordDTO(
          [void Function(ForgotPasswordDTOBuilder)? updates]) =>
      (ForgotPasswordDTOBuilder()..update(updates))._build();

  _$ForgotPasswordDTO._({required this.email}) : super._();
  @override
  ForgotPasswordDTO rebuild(void Function(ForgotPasswordDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ForgotPasswordDTOBuilder toBuilder() =>
      ForgotPasswordDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ForgotPasswordDTO && email == other.email;
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
    return (newBuiltValueToStringHelper(r'ForgotPasswordDTO')
          ..add('email', email))
        .toString();
  }
}

class ForgotPasswordDTOBuilder
    implements Builder<ForgotPasswordDTO, ForgotPasswordDTOBuilder> {
  _$ForgotPasswordDTO? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  ForgotPasswordDTOBuilder() {
    ForgotPasswordDTO._defaults(this);
  }

  ForgotPasswordDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ForgotPasswordDTO other) {
    _$v = other as _$ForgotPasswordDTO;
  }

  @override
  void update(void Function(ForgotPasswordDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ForgotPasswordDTO build() => _build();

  _$ForgotPasswordDTO _build() {
    final _$result = _$v ??
        _$ForgotPasswordDTO._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'ForgotPasswordDTO', 'email'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
