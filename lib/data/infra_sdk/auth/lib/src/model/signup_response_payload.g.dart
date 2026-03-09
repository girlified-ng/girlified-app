// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'signup_response_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SignupResponsePayload extends SignupResponsePayload {
  @override
  final String signupVerificationHash;

  factory _$SignupResponsePayload(
          [void Function(SignupResponsePayloadBuilder)? updates]) =>
      (SignupResponsePayloadBuilder()..update(updates))._build();

  _$SignupResponsePayload._({required this.signupVerificationHash}) : super._();
  @override
  SignupResponsePayload rebuild(
          void Function(SignupResponsePayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SignupResponsePayloadBuilder toBuilder() =>
      SignupResponsePayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SignupResponsePayload &&
        signupVerificationHash == other.signupVerificationHash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signupVerificationHash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SignupResponsePayload')
          ..add('signupVerificationHash', signupVerificationHash))
        .toString();
  }
}

class SignupResponsePayloadBuilder
    implements Builder<SignupResponsePayload, SignupResponsePayloadBuilder> {
  _$SignupResponsePayload? _$v;

  String? _signupVerificationHash;
  String? get signupVerificationHash => _$this._signupVerificationHash;
  set signupVerificationHash(String? signupVerificationHash) =>
      _$this._signupVerificationHash = signupVerificationHash;

  SignupResponsePayloadBuilder() {
    SignupResponsePayload._defaults(this);
  }

  SignupResponsePayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signupVerificationHash = $v.signupVerificationHash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SignupResponsePayload other) {
    _$v = other as _$SignupResponsePayload;
  }

  @override
  void update(void Function(SignupResponsePayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SignupResponsePayload build() => _build();

  _$SignupResponsePayload _build() {
    final _$result = _$v ??
        _$SignupResponsePayload._(
          signupVerificationHash: BuiltValueNullFieldError.checkNotNull(
              signupVerificationHash,
              r'SignupResponsePayload',
              'signupVerificationHash'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
