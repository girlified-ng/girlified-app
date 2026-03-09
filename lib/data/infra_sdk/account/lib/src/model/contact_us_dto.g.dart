// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'contact_us_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ContactUsDTO extends ContactUsDTO {
  @override
  final String name;
  @override
  final String email;
  @override
  final String subject;
  @override
  final String message;

  factory _$ContactUsDTO([void Function(ContactUsDTOBuilder)? updates]) =>
      (ContactUsDTOBuilder()..update(updates))._build();

  _$ContactUsDTO._(
      {required this.name,
      required this.email,
      required this.subject,
      required this.message})
      : super._();
  @override
  ContactUsDTO rebuild(void Function(ContactUsDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ContactUsDTOBuilder toBuilder() => ContactUsDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ContactUsDTO &&
        name == other.name &&
        email == other.email &&
        subject == other.subject &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, subject.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ContactUsDTO')
          ..add('name', name)
          ..add('email', email)
          ..add('subject', subject)
          ..add('message', message))
        .toString();
  }
}

class ContactUsDTOBuilder
    implements Builder<ContactUsDTO, ContactUsDTOBuilder> {
  _$ContactUsDTO? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _subject;
  String? get subject => _$this._subject;
  set subject(String? subject) => _$this._subject = subject;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ContactUsDTOBuilder() {
    ContactUsDTO._defaults(this);
  }

  ContactUsDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _email = $v.email;
      _subject = $v.subject;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ContactUsDTO other) {
    _$v = other as _$ContactUsDTO;
  }

  @override
  void update(void Function(ContactUsDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ContactUsDTO build() => _build();

  _$ContactUsDTO _build() {
    final _$result = _$v ??
        _$ContactUsDTO._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'ContactUsDTO', 'name'),
          email: BuiltValueNullFieldError.checkNotNull(
              email, r'ContactUsDTO', 'email'),
          subject: BuiltValueNullFieldError.checkNotNull(
              subject, r'ContactUsDTO', 'subject'),
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'ContactUsDTO', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
