// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'monthly_survey_history_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MonthlySurveyHistoryResponse extends MonthlySurveyHistoryResponse {
  @override
  final BuiltList<MonthlySurveyInfo> surveys;
  @override
  final num totalPages;
  @override
  final bool hasNext;

  factory _$MonthlySurveyHistoryResponse(
          [void Function(MonthlySurveyHistoryResponseBuilder)? updates]) =>
      (MonthlySurveyHistoryResponseBuilder()..update(updates))._build();

  _$MonthlySurveyHistoryResponse._(
      {required this.surveys, required this.totalPages, required this.hasNext})
      : super._();
  @override
  MonthlySurveyHistoryResponse rebuild(
          void Function(MonthlySurveyHistoryResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MonthlySurveyHistoryResponseBuilder toBuilder() =>
      MonthlySurveyHistoryResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MonthlySurveyHistoryResponse &&
        surveys == other.surveys &&
        totalPages == other.totalPages &&
        hasNext == other.hasNext;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, surveys.hashCode);
    _$hash = $jc(_$hash, totalPages.hashCode);
    _$hash = $jc(_$hash, hasNext.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MonthlySurveyHistoryResponse')
          ..add('surveys', surveys)
          ..add('totalPages', totalPages)
          ..add('hasNext', hasNext))
        .toString();
  }
}

class MonthlySurveyHistoryResponseBuilder
    implements
        Builder<MonthlySurveyHistoryResponse,
            MonthlySurveyHistoryResponseBuilder> {
  _$MonthlySurveyHistoryResponse? _$v;

  ListBuilder<MonthlySurveyInfo>? _surveys;
  ListBuilder<MonthlySurveyInfo> get surveys =>
      _$this._surveys ??= ListBuilder<MonthlySurveyInfo>();
  set surveys(ListBuilder<MonthlySurveyInfo>? surveys) =>
      _$this._surveys = surveys;

  num? _totalPages;
  num? get totalPages => _$this._totalPages;
  set totalPages(num? totalPages) => _$this._totalPages = totalPages;

  bool? _hasNext;
  bool? get hasNext => _$this._hasNext;
  set hasNext(bool? hasNext) => _$this._hasNext = hasNext;

  MonthlySurveyHistoryResponseBuilder() {
    MonthlySurveyHistoryResponse._defaults(this);
  }

  MonthlySurveyHistoryResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _surveys = $v.surveys.toBuilder();
      _totalPages = $v.totalPages;
      _hasNext = $v.hasNext;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MonthlySurveyHistoryResponse other) {
    _$v = other as _$MonthlySurveyHistoryResponse;
  }

  @override
  void update(void Function(MonthlySurveyHistoryResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MonthlySurveyHistoryResponse build() => _build();

  _$MonthlySurveyHistoryResponse _build() {
    _$MonthlySurveyHistoryResponse _$result;
    try {
      _$result = _$v ??
          _$MonthlySurveyHistoryResponse._(
            surveys: surveys.build(),
            totalPages: BuiltValueNullFieldError.checkNotNull(
                totalPages, r'MonthlySurveyHistoryResponse', 'totalPages'),
            hasNext: BuiltValueNullFieldError.checkNotNull(
                hasNext, r'MonthlySurveyHistoryResponse', 'hasNext'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'surveys';
        surveys.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'MonthlySurveyHistoryResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
