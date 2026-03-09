// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:account_sdk/src/model/monthly_survey_info.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'monthly_survey_history_response.g.dart';

/// MonthlySurveyHistoryResponse
///
/// Properties:
/// * [surveys] - Monthly survey history.
/// * [totalPages] - Total number of pages.
/// * [hasNext] - Has next page.
@BuiltValue()
abstract class MonthlySurveyHistoryResponse implements Built<MonthlySurveyHistoryResponse, MonthlySurveyHistoryResponseBuilder> {
  /// Monthly survey history.
  @BuiltValueField(wireName: r'surveys')
  BuiltList<MonthlySurveyInfo> get surveys;

  /// Total number of pages.
  @BuiltValueField(wireName: r'totalPages')
  num get totalPages;

  /// Has next page.
  @BuiltValueField(wireName: r'hasNext')
  bool get hasNext;

  MonthlySurveyHistoryResponse._();

  factory MonthlySurveyHistoryResponse([void updates(MonthlySurveyHistoryResponseBuilder b)]) = _$MonthlySurveyHistoryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonthlySurveyHistoryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonthlySurveyHistoryResponse> get serializer => _$MonthlySurveyHistoryResponseSerializer();
}

class _$MonthlySurveyHistoryResponseSerializer implements PrimitiveSerializer<MonthlySurveyHistoryResponse> {
  @override
  final Iterable<Type> types = const [MonthlySurveyHistoryResponse, _$MonthlySurveyHistoryResponse];

  @override
  final String wireName = r'MonthlySurveyHistoryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonthlySurveyHistoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'surveys';
    yield serializers.serialize(
      object.surveys,
      specifiedType: const FullType(BuiltList, [FullType(MonthlySurveyInfo)]),
    );
    yield r'totalPages';
    yield serializers.serialize(
      object.totalPages,
      specifiedType: const FullType(num),
    );
    yield r'hasNext';
    yield serializers.serialize(
      object.hasNext,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonthlySurveyHistoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MonthlySurveyHistoryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'surveys':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MonthlySurveyInfo)]),
          ) as BuiltList<MonthlySurveyInfo>;
          result.surveys.replace(valueDes);
          break;
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPages = valueDes;
          break;
        case r'hasNext':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasNext = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonthlySurveyHistoryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonthlySurveyHistoryResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

