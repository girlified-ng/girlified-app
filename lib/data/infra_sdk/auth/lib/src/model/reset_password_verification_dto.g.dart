// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'reset_password_verification_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordVerificationDTO extends ResetPasswordVerificationDTO {
  @override
  final String email;
  @override
  final String otp;

  factory _$ResetPasswordVerificationDTO(
          [void Function(ResetPasswordVerificationDTOBuilder)? updates]) =>
      (ResetPasswordVerificationDTOBuilder()..update(updates))._build();

  _$ResetPasswordVerificationDTO._({required this.email, required this.otp})
      : super._();
  @override
  ResetPasswordVerificationDTO rebuild(
          void Function(ResetPasswordVerificationDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordVerificationDTOBuilder toBuilder() =>
      ResetPasswordVerificationDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordVerificationDTO &&
        email == other.email &&
        otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ResetPasswordVerificationDTO')
          ..add('email', email)
          ..add('otp', otp))
        .toString();
  }
}

class ResetPasswordVerificationDTOBuilder
    implements
        Builder<ResetPasswordVerificationDTO,
            ResetPasswordVerificationDTOBuilder> {
  _$ResetPasswordVerificationDTO? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  ResetPasswordVerificationDTOBuilder() {
    ResetPasswordVerificationDTO._defaults(this);
  }

  ResetPasswordVerificationDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordVerificationDTO other) {
    _$v = other as _$ResetPasswordVerificationDTO;
  }

  @override
  void update(void Function(ResetPasswordVerificationDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordVerificationDTO build() => _build();

  _$ResetPasswordVerificationDTO _build() {
    final _$result = _$v ??
        _$ResetPasswordVerificationDTO._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'ResetPasswordVerificationDTO', 'email'),
          otp: BuiltValueNullFieldError.checkNotNull(
              otp, r'ResetPasswordVerificationDTO', 'otp'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
