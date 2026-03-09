// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'complete_signup_verification_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CompleteSignupVerificationDTO extends CompleteSignupVerificationDTO {
  @override
  final String signupVerificationHash;
  @override
  final String otp;

  factory _$CompleteSignupVerificationDTO(
          [void Function(CompleteSignupVerificationDTOBuilder)? updates]) =>
      (CompleteSignupVerificationDTOBuilder()..update(updates))._build();

  _$CompleteSignupVerificationDTO._(
      {required this.signupVerificationHash, required this.otp})
      : super._();
  @override
  CompleteSignupVerificationDTO rebuild(
          void Function(CompleteSignupVerificationDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CompleteSignupVerificationDTOBuilder toBuilder() =>
      CompleteSignupVerificationDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CompleteSignupVerificationDTO &&
        signupVerificationHash == other.signupVerificationHash &&
        otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, signupVerificationHash.hashCode);
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CompleteSignupVerificationDTO')
          ..add('signupVerificationHash', signupVerificationHash)
          ..add('otp', otp))
        .toString();
  }
}

class CompleteSignupVerificationDTOBuilder
    implements
        Builder<CompleteSignupVerificationDTO,
            CompleteSignupVerificationDTOBuilder> {
  _$CompleteSignupVerificationDTO? _$v;

  String? _signupVerificationHash;
  String? get signupVerificationHash => _$this._signupVerificationHash;
  set signupVerificationHash(String? signupVerificationHash) =>
      _$this._signupVerificationHash = signupVerificationHash;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  CompleteSignupVerificationDTOBuilder() {
    CompleteSignupVerificationDTO._defaults(this);
  }

  CompleteSignupVerificationDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _signupVerificationHash = $v.signupVerificationHash;
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CompleteSignupVerificationDTO other) {
    _$v = other as _$CompleteSignupVerificationDTO;
  }

  @override
  void update(void Function(CompleteSignupVerificationDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CompleteSignupVerificationDTO build() => _build();

  _$CompleteSignupVerificationDTO _build() {
    final _$result = _$v ??
        _$CompleteSignupVerificationDTO._(
          signupVerificationHash: BuiltValueNullFieldError.checkNotNull(
              signupVerificationHash,
              r'CompleteSignupVerificationDTO',
              'signupVerificationHash'),
          otp: BuiltValueNullFieldError.checkNotNull(
              otp, r'CompleteSignupVerificationDTO', 'otp'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
