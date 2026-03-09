// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'register_monthly_survey_dto.g.dart';

/// RegisterMonthlySurveyDTO
///
/// Properties:
/// * [hasAccessToPad] 
/// * [daysManagingMenstruation] 
/// * [challengesFaced] 
@BuiltValue()
abstract class RegisterMonthlySurveyDTO implements Built<RegisterMonthlySurveyDTO, RegisterMonthlySurveyDTOBuilder> {
  @BuiltValueField(wireName: r'hasAccessToPad')
  bool get hasAccessToPad;

  @BuiltValueField(wireName: r'daysManagingMenstruation')
  RegisterMonthlySurveyDTODaysManagingMenstruationEnum get daysManagingMenstruation;
  // enum daysManagingMenstruationEnum {  None,  OneToThreeDays,  FourToFiveDays,  MoreThanFiveDays,  };

  @BuiltValueField(wireName: r'challengesFaced')
  String get challengesFaced;

  RegisterMonthlySurveyDTO._();

  factory RegisterMonthlySurveyDTO([void updates(RegisterMonthlySurveyDTOBuilder b)]) = _$RegisterMonthlySurveyDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RegisterMonthlySurveyDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RegisterMonthlySurveyDTO> get serializer => _$RegisterMonthlySurveyDTOSerializer();
}

class _$RegisterMonthlySurveyDTOSerializer implements PrimitiveSerializer<RegisterMonthlySurveyDTO> {
  @override
  final Iterable<Type> types = const [RegisterMonthlySurveyDTO, _$RegisterMonthlySurveyDTO];

  @override
  final String wireName = r'RegisterMonthlySurveyDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RegisterMonthlySurveyDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'hasAccessToPad';
    yield serializers.serialize(
      object.hasAccessToPad,
      specifiedType: const FullType(bool),
    );
    yield r'daysManagingMenstruation';
    yield serializers.serialize(
      object.daysManagingMenstruation,
      specifiedType: const FullType(RegisterMonthlySurveyDTODaysManagingMenstruationEnum),
    );
    yield r'challengesFaced';
    yield serializers.serialize(
      object.challengesFaced,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    RegisterMonthlySurveyDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RegisterMonthlySurveyDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'hasAccessToPad':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasAccessToPad = valueDes;
          break;
        case r'daysManagingMenstruation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RegisterMonthlySurveyDTODaysManagingMenstruationEnum),
          ) as RegisterMonthlySurveyDTODaysManagingMenstruationEnum;
          result.daysManagingMenstruation = valueDes;
          break;
        case r'challengesFaced':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.challengesFaced = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  RegisterMonthlySurveyDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RegisterMonthlySurveyDTOBuilder();
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

class RegisterMonthlySurveyDTODaysManagingMenstruationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'None')
  static const RegisterMonthlySurveyDTODaysManagingMenstruationEnum none = _$registerMonthlySurveyDTODaysManagingMenstruationEnum_none;
  @BuiltValueEnumConst(wireName: r'OneToThreeDays')
  static const RegisterMonthlySurveyDTODaysManagingMenstruationEnum oneToThreeDays = _$registerMonthlySurveyDTODaysManagingMenstruationEnum_oneToThreeDays;
  @BuiltValueEnumConst(wireName: r'FourToFiveDays')
  static const RegisterMonthlySurveyDTODaysManagingMenstruationEnum fourToFiveDays = _$registerMonthlySurveyDTODaysManagingMenstruationEnum_fourToFiveDays;
  @BuiltValueEnumConst(wireName: r'MoreThanFiveDays')
  static const RegisterMonthlySurveyDTODaysManagingMenstruationEnum moreThanFiveDays = _$registerMonthlySurveyDTODaysManagingMenstruationEnum_moreThanFiveDays;

  static Serializer<RegisterMonthlySurveyDTODaysManagingMenstruationEnum> get serializer => _$registerMonthlySurveyDTODaysManagingMenstruationEnumSerializer;

  const RegisterMonthlySurveyDTODaysManagingMenstruationEnum._(String name): super(name);

  static BuiltSet<RegisterMonthlySurveyDTODaysManagingMenstruationEnum> get values => _$registerMonthlySurveyDTODaysManagingMenstruationEnumValues;
  static RegisterMonthlySurveyDTODaysManagingMenstruationEnum valueOf(String name) => _$registerMonthlySurveyDTODaysManagingMenstruationEnumValueOf(name);
}

