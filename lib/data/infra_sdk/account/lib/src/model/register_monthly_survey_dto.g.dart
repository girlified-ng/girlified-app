// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'register_monthly_survey_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RegisterMonthlySurveyDTODaysManagingMenstruationEnum
    _$registerMonthlySurveyDTODaysManagingMenstruationEnum_none =
    const RegisterMonthlySurveyDTODaysManagingMenstruationEnum._('none');
const RegisterMonthlySurveyDTODaysManagingMenstruationEnum
    _$registerMonthlySurveyDTODaysManagingMenstruationEnum_oneToThreeDays =
    const RegisterMonthlySurveyDTODaysManagingMenstruationEnum._(
        'oneToThreeDays');
const RegisterMonthlySurveyDTODaysManagingMenstruationEnum
    _$registerMonthlySurveyDTODaysManagingMenstruationEnum_fourToFiveDays =
    const RegisterMonthlySurveyDTODaysManagingMenstruationEnum._(
        'fourToFiveDays');
const RegisterMonthlySurveyDTODaysManagingMenstruationEnum
    _$registerMonthlySurveyDTODaysManagingMenstruationEnum_moreThanFiveDays =
    const RegisterMonthlySurveyDTODaysManagingMenstruationEnum._(
        'moreThanFiveDays');

RegisterMonthlySurveyDTODaysManagingMenstruationEnum
    _$registerMonthlySurveyDTODaysManagingMenstruationEnumValueOf(String name) {
  switch (name) {
    case 'none':
      return _$registerMonthlySurveyDTODaysManagingMenstruationEnum_none;
    case 'oneToThreeDays':
      return _$registerMonthlySurveyDTODaysManagingMenstruationEnum_oneToThreeDays;
    case 'fourToFiveDays':
      return _$registerMonthlySurveyDTODaysManagingMenstruationEnum_fourToFiveDays;
    case 'moreThanFiveDays':
      return _$registerMonthlySurveyDTODaysManagingMenstruationEnum_moreThanFiveDays;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<RegisterMonthlySurveyDTODaysManagingMenstruationEnum>
    _$registerMonthlySurveyDTODaysManagingMenstruationEnumValues = BuiltSet<
        RegisterMonthlySurveyDTODaysManagingMenstruationEnum>(const <RegisterMonthlySurveyDTODaysManagingMenstruationEnum>[
  _$registerMonthlySurveyDTODaysManagingMenstruationEnum_none,
  _$registerMonthlySurveyDTODaysManagingMenstruationEnum_oneToThreeDays,
  _$registerMonthlySurveyDTODaysManagingMenstruationEnum_fourToFiveDays,
  _$registerMonthlySurveyDTODaysManagingMenstruationEnum_moreThanFiveDays,
]);

Serializer<RegisterMonthlySurveyDTODaysManagingMenstruationEnum>
    _$registerMonthlySurveyDTODaysManagingMenstruationEnumSerializer =
    _$RegisterMonthlySurveyDTODaysManagingMenstruationEnumSerializer();

class _$RegisterMonthlySurveyDTODaysManagingMenstruationEnumSerializer
    implements
        PrimitiveSerializer<
            RegisterMonthlySurveyDTODaysManagingMenstruationEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'None',
    'oneToThreeDays': 'OneToThreeDays',
    'fourToFiveDays': 'FourToFiveDays',
    'moreThanFiveDays': 'MoreThanFiveDays',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'None': 'none',
    'OneToThreeDays': 'oneToThreeDays',
    'FourToFiveDays': 'fourToFiveDays',
    'MoreThanFiveDays': 'moreThanFiveDays',
  };

  @override
  final Iterable<Type> types = const <Type>[
    RegisterMonthlySurveyDTODaysManagingMenstruationEnum
  ];
  @override
  final String wireName =
      'RegisterMonthlySurveyDTODaysManagingMenstruationEnum';

  @override
  Object serialize(Serializers serializers,
          RegisterMonthlySurveyDTODaysManagingMenstruationEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RegisterMonthlySurveyDTODaysManagingMenstruationEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RegisterMonthlySurveyDTODaysManagingMenstruationEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$RegisterMonthlySurveyDTO extends RegisterMonthlySurveyDTO {
  @override
  final bool hasAccessToPad;
  @override
  final RegisterMonthlySurveyDTODaysManagingMenstruationEnum
      daysManagingMenstruation;
  @override
  final String challengesFaced;

  factory _$RegisterMonthlySurveyDTO(
          [void Function(RegisterMonthlySurveyDTOBuilder)? updates]) =>
      (RegisterMonthlySurveyDTOBuilder()..update(updates))._build();

  _$RegisterMonthlySurveyDTO._(
      {required this.hasAccessToPad,
      required this.daysManagingMenstruation,
      required this.challengesFaced})
      : super._();
  @override
  RegisterMonthlySurveyDTO rebuild(
          void Function(RegisterMonthlySurveyDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterMonthlySurveyDTOBuilder toBuilder() =>
      RegisterMonthlySurveyDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterMonthlySurveyDTO &&
        hasAccessToPad == other.hasAccessToPad &&
        daysManagingMenstruation == other.daysManagingMenstruation &&
        challengesFaced == other.challengesFaced;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, hasAccessToPad.hashCode);
    _$hash = $jc(_$hash, daysManagingMenstruation.hashCode);
    _$hash = $jc(_$hash, challengesFaced.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterMonthlySurveyDTO')
          ..add('hasAccessToPad', hasAccessToPad)
          ..add('daysManagingMenstruation', daysManagingMenstruation)
          ..add('challengesFaced', challengesFaced))
        .toString();
  }
}

class RegisterMonthlySurveyDTOBuilder
    implements
        Builder<RegisterMonthlySurveyDTO, RegisterMonthlySurveyDTOBuilder> {
  _$RegisterMonthlySurveyDTO? _$v;

  bool? _hasAccessToPad;
  bool? get hasAccessToPad => _$this._hasAccessToPad;
  set hasAccessToPad(bool? hasAccessToPad) =>
      _$this._hasAccessToPad = hasAccessToPad;

  RegisterMonthlySurveyDTODaysManagingMenstruationEnum?
      _daysManagingMenstruation;
  RegisterMonthlySurveyDTODaysManagingMenstruationEnum?
      get daysManagingMenstruation => _$this._daysManagingMenstruation;
  set daysManagingMenstruation(
          RegisterMonthlySurveyDTODaysManagingMenstruationEnum?
              daysManagingMenstruation) =>
      _$this._daysManagingMenstruation = daysManagingMenstruation;

  String? _challengesFaced;
  String? get challengesFaced => _$this._challengesFaced;
  set challengesFaced(String? challengesFaced) =>
      _$this._challengesFaced = challengesFaced;

  RegisterMonthlySurveyDTOBuilder() {
    RegisterMonthlySurveyDTO._defaults(this);
  }

  RegisterMonthlySurveyDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _hasAccessToPad = $v.hasAccessToPad;
      _daysManagingMenstruation = $v.daysManagingMenstruation;
      _challengesFaced = $v.challengesFaced;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterMonthlySurveyDTO other) {
    _$v = other as _$RegisterMonthlySurveyDTO;
  }

  @override
  void update(void Function(RegisterMonthlySurveyDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterMonthlySurveyDTO build() => _build();

  _$RegisterMonthlySurveyDTO _build() {
    final _$result = _$v ??
        _$RegisterMonthlySurveyDTO._(
          hasAccessToPad: BuiltValueNullFieldError.checkNotNull(
              hasAccessToPad, r'RegisterMonthlySurveyDTO', 'hasAccessToPad'),
          daysManagingMenstruation: BuiltValueNullFieldError.checkNotNull(
              daysManagingMenstruation,
              r'RegisterMonthlySurveyDTO',
              'daysManagingMenstruation'),
          challengesFaced: BuiltValueNullFieldError.checkNotNull(
              challengesFaced, r'RegisterMonthlySurveyDTO', 'challengesFaced'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
