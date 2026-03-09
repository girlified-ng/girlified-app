// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'delete_account_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeleteAccountDTO extends DeleteAccountDTO {
  @override
  final String password;

  factory _$DeleteAccountDTO(
          [void Function(DeleteAccountDTOBuilder)? updates]) =>
      (DeleteAccountDTOBuilder()..update(updates))._build();

  _$DeleteAccountDTO._({required this.password}) : super._();
  @override
  DeleteAccountDTO rebuild(void Function(DeleteAccountDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeleteAccountDTOBuilder toBuilder() =>
      DeleteAccountDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeleteAccountDTO && password == other.password;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeleteAccountDTO')
          ..add('password', password))
        .toString();
  }
}

class DeleteAccountDTOBuilder
    implements Builder<DeleteAccountDTO, DeleteAccountDTOBuilder> {
  _$DeleteAccountDTO? _$v;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  DeleteAccountDTOBuilder() {
    DeleteAccountDTO._defaults(this);
  }

  DeleteAccountDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _password = $v.password;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeleteAccountDTO other) {
    _$v = other as _$DeleteAccountDTO;
  }

  @override
  void update(void Function(DeleteAccountDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeleteAccountDTO build() => _build();

  _$DeleteAccountDTO _build() {
    final _$result = _$v ??
        _$DeleteAccountDTO._(
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'DeleteAccountDTO', 'password'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
