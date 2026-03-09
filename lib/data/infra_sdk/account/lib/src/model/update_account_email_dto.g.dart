// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_account_email_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAccountEmailDTO extends UpdateAccountEmailDTO {
  @override
  final String newEmail;

  factory _$UpdateAccountEmailDTO(
          [void Function(UpdateAccountEmailDTOBuilder)? updates]) =>
      (UpdateAccountEmailDTOBuilder()..update(updates))._build();

  _$UpdateAccountEmailDTO._({required this.newEmail}) : super._();
  @override
  UpdateAccountEmailDTO rebuild(
          void Function(UpdateAccountEmailDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAccountEmailDTOBuilder toBuilder() =>
      UpdateAccountEmailDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAccountEmailDTO && newEmail == other.newEmail;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, newEmail.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAccountEmailDTO')
          ..add('newEmail', newEmail))
        .toString();
  }
}

class UpdateAccountEmailDTOBuilder
    implements Builder<UpdateAccountEmailDTO, UpdateAccountEmailDTOBuilder> {
  _$UpdateAccountEmailDTO? _$v;

  String? _newEmail;
  String? get newEmail => _$this._newEmail;
  set newEmail(String? newEmail) => _$this._newEmail = newEmail;

  UpdateAccountEmailDTOBuilder() {
    UpdateAccountEmailDTO._defaults(this);
  }

  UpdateAccountEmailDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _newEmail = $v.newEmail;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAccountEmailDTO other) {
    _$v = other as _$UpdateAccountEmailDTO;
  }

  @override
  void update(void Function(UpdateAccountEmailDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAccountEmailDTO build() => _build();

  _$UpdateAccountEmailDTO _build() {
    final _$result = _$v ??
        _$UpdateAccountEmailDTO._(
          newEmail: BuiltValueNullFieldError.checkNotNull(
              newEmail, r'UpdateAccountEmailDTO', 'newEmail'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
