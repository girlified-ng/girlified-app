// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'signin_response_payload.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SigninResponsePayload extends SigninResponsePayload {
  @override
  final String token;

  factory _$SigninResponsePayload(
          [void Function(SigninResponsePayloadBuilder)? updates]) =>
      (SigninResponsePayloadBuilder()..update(updates))._build();

  _$SigninResponsePayload._({required this.token}) : super._();
  @override
  SigninResponsePayload rebuild(
          void Function(SigninResponsePayloadBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SigninResponsePayloadBuilder toBuilder() =>
      SigninResponsePayloadBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SigninResponsePayload && token == other.token;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, token.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SigninResponsePayload')
          ..add('token', token))
        .toString();
  }
}

class SigninResponsePayloadBuilder
    implements Builder<SigninResponsePayload, SigninResponsePayloadBuilder> {
  _$SigninResponsePayload? _$v;

  String? _token;
  String? get token => _$this._token;
  set token(String? token) => _$this._token = token;

  SigninResponsePayloadBuilder() {
    SigninResponsePayload._defaults(this);
  }

  SigninResponsePayloadBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _token = $v.token;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SigninResponsePayload other) {
    _$v = other as _$SigninResponsePayload;
  }

  @override
  void update(void Function(SigninResponsePayloadBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SigninResponsePayload build() => _build();

  _$SigninResponsePayload _build() {
    final _$result = _$v ??
        _$SigninResponsePayload._(
          token: BuiltValueNullFieldError.checkNotNull(
              token, r'SigninResponsePayload', 'token'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
