// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'monthly_survey_info.g.dart';

/// MonthlySurveyInfo
///
/// Properties:
/// * [id] - Monthly survey ID (Auto generated).
/// * [daysManagingPeriod] - Monthly survey days managing period.
/// * [challengesFaced] - Monthly survey challengesFaced.
/// * [hasAccessToPad] - Monthly survey hasAccessToPad.
@BuiltValue()
abstract class MonthlySurveyInfo implements Built<MonthlySurveyInfo, MonthlySurveyInfoBuilder> {
  /// Monthly survey ID (Auto generated).
  @BuiltValueField(wireName: r'id')
  String get id;

  /// Monthly survey days managing period.
  @BuiltValueField(wireName: r'daysManagingPeriod')
  String get daysManagingPeriod;

  /// Monthly survey challengesFaced.
  @BuiltValueField(wireName: r'challengesFaced')
  BuiltList<String> get challengesFaced;

  /// Monthly survey hasAccessToPad.
  @BuiltValueField(wireName: r'hasAccessToPad')
  bool get hasAccessToPad;

  MonthlySurveyInfo._();

  factory MonthlySurveyInfo([void updates(MonthlySurveyInfoBuilder b)]) = _$MonthlySurveyInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MonthlySurveyInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MonthlySurveyInfo> get serializer => _$MonthlySurveyInfoSerializer();
}

class _$MonthlySurveyInfoSerializer implements PrimitiveSerializer<MonthlySurveyInfo> {
  @override
  final Iterable<Type> types = const [MonthlySurveyInfo, _$MonthlySurveyInfo];

  @override
  final String wireName = r'MonthlySurveyInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MonthlySurveyInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'daysManagingPeriod';
    yield serializers.serialize(
      object.daysManagingPeriod,
      specifiedType: const FullType(String),
    );
    yield r'challengesFaced';
    yield serializers.serialize(
      object.challengesFaced,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'hasAccessToPad';
    yield serializers.serialize(
      object.hasAccessToPad,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MonthlySurveyInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MonthlySurveyInfoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'daysManagingPeriod':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.daysManagingPeriod = valueDes;
          break;
        case r'challengesFaced':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.challengesFaced.replace(valueDes);
          break;
        case r'hasAccessToPad':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAccessToPad = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MonthlySurveyInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MonthlySurveyInfoBuilder();
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

