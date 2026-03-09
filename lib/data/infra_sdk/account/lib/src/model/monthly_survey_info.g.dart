// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'monthly_survey_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonthlySurveyInfo extends MonthlySurveyInfo {
  @override
  final String id;
  @override
  final String daysManagingPeriod;
  @override
  final BuiltList<String> challengesFaced;
  @override
  final bool hasAccessToPad;

  factory _$MonthlySurveyInfo(
          [void Function(MonthlySurveyInfoBuilder)? updates]) =>
      (MonthlySurveyInfoBuilder()..update(updates))._build();

  _$MonthlySurveyInfo._(
      {required this.id,
      required this.daysManagingPeriod,
      required this.challengesFaced,
      required this.hasAccessToPad})
      : super._();
  @override
  MonthlySurveyInfo rebuild(void Function(MonthlySurveyInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonthlySurveyInfoBuilder toBuilder() =>
      MonthlySurveyInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonthlySurveyInfo &&
        id == other.id &&
        daysManagingPeriod == other.daysManagingPeriod &&
        challengesFaced == other.challengesFaced &&
        hasAccessToPad == other.hasAccessToPad;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, daysManagingPeriod.hashCode);
    _$hash = $jc(_$hash, challengesFaced.hashCode);
    _$hash = $jc(_$hash, hasAccessToPad.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonthlySurveyInfo')
          ..add('id', id)
          ..add('daysManagingPeriod', daysManagingPeriod)
          ..add('challengesFaced', challengesFaced)
          ..add('hasAccessToPad', hasAccessToPad))
        .toString();
  }
}

class MonthlySurveyInfoBuilder
    implements Builder<MonthlySurveyInfo, MonthlySurveyInfoBuilder> {
  _$MonthlySurveyInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _daysManagingPeriod;
  String? get daysManagingPeriod => _$this._daysManagingPeriod;
  set daysManagingPeriod(String? daysManagingPeriod) =>
      _$this._daysManagingPeriod = daysManagingPeriod;

  ListBuilder<String>? _challengesFaced;
  ListBuilder<String> get challengesFaced =>
      _$this._challengesFaced ??= ListBuilder<String>();
  set challengesFaced(ListBuilder<String>? challengesFaced) =>
      _$this._challengesFaced = challengesFaced;

  bool? _hasAccessToPad;
  bool? get hasAccessToPad => _$this._hasAccessToPad;
  set hasAccessToPad(bool? hasAccessToPad) =>
      _$this._hasAccessToPad = hasAccessToPad;

  MonthlySurveyInfoBuilder() {
    MonthlySurveyInfo._defaults(this);
  }

  MonthlySurveyInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _daysManagingPeriod = $v.daysManagingPeriod;
      _challengesFaced = $v.challengesFaced.toBuilder();
      _hasAccessToPad = $v.hasAccessToPad;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonthlySurveyInfo other) {
    _$v = other as _$MonthlySurveyInfo;
  }

  @override
  void update(void Function(MonthlySurveyInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonthlySurveyInfo build() => _build();

  _$MonthlySurveyInfo _build() {
    _$MonthlySurveyInfo _$result;
    try {
      _$result = _$v ??
          _$MonthlySurveyInfo._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'MonthlySurveyInfo', 'id'),
            daysManagingPeriod: BuiltValueNullFieldError.checkNotNull(
                daysManagingPeriod, r'MonthlySurveyInfo', 'daysManagingPeriod'),
            challengesFaced: challengesFaced.build(),
            hasAccessToPad: BuiltValueNullFieldError.checkNotNull(
                hasAccessToPad, r'MonthlySurveyInfo', 'hasAccessToPad'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'challengesFaced';
        challengesFaced.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MonthlySurveyInfo', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
