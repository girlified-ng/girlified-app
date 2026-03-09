// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_account_name_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateAccountNameDTO extends UpdateAccountNameDTO {
  @override
  final String firstName;
  @override
  final String lastName;

  factory _$UpdateAccountNameDTO(
          [void Function(UpdateAccountNameDTOBuilder)? updates]) =>
      (UpdateAccountNameDTOBuilder()..update(updates))._build();

  _$UpdateAccountNameDTO._({required this.firstName, required this.lastName})
      : super._();
  @override
  UpdateAccountNameDTO rebuild(
          void Function(UpdateAccountNameDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateAccountNameDTOBuilder toBuilder() =>
      UpdateAccountNameDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateAccountNameDTO &&
        firstName == other.firstName &&
        lastName == other.lastName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateAccountNameDTO')
          ..add('firstName', firstName)
          ..add('lastName', lastName))
        .toString();
  }
}

class UpdateAccountNameDTOBuilder
    implements Builder<UpdateAccountNameDTO, UpdateAccountNameDTOBuilder> {
  _$UpdateAccountNameDTO? _$v;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  UpdateAccountNameDTOBuilder() {
    UpdateAccountNameDTO._defaults(this);
  }

  UpdateAccountNameDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateAccountNameDTO other) {
    _$v = other as _$UpdateAccountNameDTO;
  }

  @override
  void update(void Function(UpdateAccountNameDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateAccountNameDTO build() => _build();

  _$UpdateAccountNameDTO _build() {
    final _$result = _$v ??
        _$UpdateAccountNameDTO._(
          firstName: BuiltValueNullFieldError.checkNotNull(
              firstName, r'UpdateAccountNameDTO', 'firstName'),
          lastName: BuiltValueNullFieldError.checkNotNull(
              lastName, r'UpdateAccountNameDTO', 'lastName'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
