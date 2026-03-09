// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'create_account_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateAccountDTO extends CreateAccountDTO {
  @override
  final String email;
  @override
  final String password;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? phone;

  factory _$CreateAccountDTO(
          [void Function(CreateAccountDTOBuilder)? updates]) =>
      (CreateAccountDTOBuilder()..update(updates))._build();

  _$CreateAccountDTO._(
      {required this.email,
      required this.password,
      required this.firstName,
      required this.lastName,
      this.phone})
      : super._();
  @override
  CreateAccountDTO rebuild(void Function(CreateAccountDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateAccountDTOBuilder toBuilder() =>
      CreateAccountDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateAccountDTO &&
        email == other.email &&
        password == other.password &&
        firstName == other.firstName &&
        lastName == other.lastName &&
        phone == other.phone;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, password.hashCode);
    _$hash = $jc(_$hash, firstName.hashCode);
    _$hash = $jc(_$hash, lastName.hashCode);
    _$hash = $jc(_$hash, phone.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateAccountDTO')
          ..add('email', email)
          ..add('password', password)
          ..add('firstName', firstName)
          ..add('lastName', lastName)
          ..add('phone', phone))
        .toString();
  }
}

class CreateAccountDTOBuilder
    implements Builder<CreateAccountDTO, CreateAccountDTOBuilder> {
  _$CreateAccountDTO? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _password;
  String? get password => _$this._password;
  set password(String? password) => _$this._password = password;

  String? _firstName;
  String? get firstName => _$this._firstName;
  set firstName(String? firstName) => _$this._firstName = firstName;

  String? _lastName;
  String? get lastName => _$this._lastName;
  set lastName(String? lastName) => _$this._lastName = lastName;

  String? _phone;
  String? get phone => _$this._phone;
  set phone(String? phone) => _$this._phone = phone;

  CreateAccountDTOBuilder() {
    CreateAccountDTO._defaults(this);
  }

  CreateAccountDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _password = $v.password;
      _firstName = $v.firstName;
      _lastName = $v.lastName;
      _phone = $v.phone;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateAccountDTO other) {
    _$v = other as _$CreateAccountDTO;
  }

  @override
  void update(void Function(CreateAccountDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateAccountDTO build() => _build();

  _$CreateAccountDTO _build() {
    final _$result = _$v ??
        _$CreateAccountDTO._(
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'CreateAccountDTO', 'email'),
          password: BuiltValueNullFieldError.checkNotNull(
              password, r'CreateAccountDTO', 'password'),
          firstName: BuiltValueNullFieldError.checkNotNull(
              firstName, r'CreateAccountDTO', 'firstName'),
          lastName: BuiltValueNullFieldError.checkNotNull(
              lastName, r'CreateAccountDTO', 'lastName'),
          phone: phone,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
