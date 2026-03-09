// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'reset_password_otp_verification_response_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ResetPasswordOTPVerificationResponsePayload
    extends ResetPasswordOTPVerificationResponsePayload {
  @override
  final String accountId;
  @override
  final String passwordResetToken;

  factory _$ResetPasswordOTPVerificationResponsePayload(
          [void Function(ResetPasswordOTPVerificationResponsePayloadBuilder)?
              updates]) =>
      (ResetPasswordOTPVerificationResponsePayloadBuilder()..update(updates))
          ._build();

  _$ResetPasswordOTPVerificationResponsePayload._(
      {required this.accountId, required this.passwordResetToken})
      : super._();
  @override
  ResetPasswordOTPVerificationResponsePayload rebuild(
          void Function(ResetPasswordOTPVerificationResponsePayloadBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ResetPasswordOTPVerificationResponsePayloadBuilder toBuilder() =>
      ResetPasswordOTPVerificationResponsePayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ResetPasswordOTPVerificationResponsePayload &&
        accountId == other.accountId &&
        passwordResetToken == other.passwordResetToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountId.hashCode);
    _$hash = $jc(_$hash, passwordResetToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'ResetPasswordOTPVerificationResponsePayload')
          ..add('accountId', accountId)
          ..add('passwordResetToken', passwordResetToken))
        .toString();
  }
}

class ResetPasswordOTPVerificationResponsePayloadBuilder
    implements
        Builder<ResetPasswordOTPVerificationResponsePayload,
            ResetPasswordOTPVerificationResponsePayloadBuilder> {
  _$ResetPasswordOTPVerificationResponsePayload? _$v;

  String? _accountId;
  String? get accountId => _$this._accountId;
  set accountId(String? accountId) => _$this._accountId = accountId;

  String? _passwordResetToken;
  String? get passwordResetToken => _$this._passwordResetToken;
  set passwordResetToken(String? passwordResetToken) =>
      _$this._passwordResetToken = passwordResetToken;

  ResetPasswordOTPVerificationResponsePayloadBuilder() {
    ResetPasswordOTPVerificationResponsePayload._defaults(this);
  }

  ResetPasswordOTPVerificationResponsePayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountId = $v.accountId;
      _passwordResetToken = $v.passwordResetToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ResetPasswordOTPVerificationResponsePayload other) {
    _$v = other as _$ResetPasswordOTPVerificationResponsePayload;
  }

  @override
  void update(
      void Function(ResetPasswordOTPVerificationResponsePayloadBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  ResetPasswordOTPVerificationResponsePayload build() => _build();

  _$ResetPasswordOTPVerificationResponsePayload _build() {
    final _$result = _$v ??
        _$ResetPasswordOTPVerificationResponsePayload._(
          accountId: BuiltValueNullFieldError.checkNotNull(accountId,
              r'ResetPasswordOTPVerificationResponsePayload', 'accountId'),
          passwordResetToken: BuiltValueNullFieldError.checkNotNull(
              passwordResetToken,
              r'ResetPasswordOTPVerificationResponsePayload',
              'passwordResetToken'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
