// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_social_handles_dto.g.dart';

/// UpdateSocialHandlesDTO
///
/// Properties:
/// * [xHandle] 
/// * [instagramHandle] 
/// * [tiktokHandle] 
/// * [snapchatHandle] 
@BuiltValue()
abstract class UpdateSocialHandlesDTO implements Built<UpdateSocialHandlesDTO, UpdateSocialHandlesDTOBuilder> {
  @BuiltValueField(wireName: r'xHandle')
  String get xHandle;

  @BuiltValueField(wireName: r'instagramHandle')
  String get instagramHandle;

  @BuiltValueField(wireName: r'tiktokHandle')
  String get tiktokHandle;

  @BuiltValueField(wireName: r'snapchatHandle')
  String get snapchatHandle;

  UpdateSocialHandlesDTO._();

  factory UpdateSocialHandlesDTO([void updates(UpdateSocialHandlesDTOBuilder b)]) = _$UpdateSocialHandlesDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateSocialHandlesDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateSocialHandlesDTO> get serializer => _$UpdateSocialHandlesDTOSerializer();
}

class _$UpdateSocialHandlesDTOSerializer implements PrimitiveSerializer<UpdateSocialHandlesDTO> {
  @override
  final Iterable<Type> types = const [UpdateSocialHandlesDTO, _$UpdateSocialHandlesDTO];

  @override
  final String wireName = r'UpdateSocialHandlesDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateSocialHandlesDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'xHandle';
    yield serializers.serialize(
      object.xHandle,
      specifiedType: const FullType(String),
    );
    yield r'instagramHandle';
    yield serializers.serialize(
      object.instagramHandle,
      specifiedType: const FullType(String),
    );
    yield r'tiktokHandle';
    yield serializers.serialize(
      object.tiktokHandle,
      specifiedType: const FullType(String),
    );
    yield r'snapchatHandle';
    yield serializers.serialize(
      object.snapchatHandle,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateSocialHandlesDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateSocialHandlesDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'xHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.xHandle = valueDes;
          break;
        case r'instagramHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.instagramHandle = valueDes;
          break;
        case r'tiktokHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.tiktokHandle = valueDes;
          break;
        case r'snapchatHandle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.snapchatHandle = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateSocialHandlesDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateSocialHandlesDTOBuilder();
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

