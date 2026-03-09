// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'verify_new_account_email_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$VerifyNewAccountEmailDTO extends VerifyNewAccountEmailDTO {
  @override
  final String otp;

  factory _$VerifyNewAccountEmailDTO(
          [void Function(VerifyNewAccountEmailDTOBuilder)? updates]) =>
      (VerifyNewAccountEmailDTOBuilder()..update(updates))._build();

  _$VerifyNewAccountEmailDTO._({required this.otp}) : super._();
  @override
  VerifyNewAccountEmailDTO rebuild(
          void Function(VerifyNewAccountEmailDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  VerifyNewAccountEmailDTOBuilder toBuilder() =>
      VerifyNewAccountEmailDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is VerifyNewAccountEmailDTO && otp == other.otp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, otp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'VerifyNewAccountEmailDTO')
          ..add('otp', otp))
        .toString();
  }
}

class VerifyNewAccountEmailDTOBuilder
    implements
        Builder<VerifyNewAccountEmailDTO, VerifyNewAccountEmailDTOBuilder> {
  _$VerifyNewAccountEmailDTO? _$v;

  String? _otp;
  String? get otp => _$this._otp;
  set otp(String? otp) => _$this._otp = otp;

  VerifyNewAccountEmailDTOBuilder() {
    VerifyNewAccountEmailDTO._defaults(this);
  }

  VerifyNewAccountEmailDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _otp = $v.otp;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(VerifyNewAccountEmailDTO other) {
    _$v = other as _$VerifyNewAccountEmailDTO;
  }

  @override
  void update(void Function(VerifyNewAccountEmailDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  VerifyNewAccountEmailDTO build() => _build();

  _$VerifyNewAccountEmailDTO _build() {
    final _$result = _$v ??
        _$VerifyNewAccountEmailDTO._(
          otp: BuiltValueNullFieldError.checkNotNull(
              otp, r'VerifyNewAccountEmailDTO', 'otp'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
