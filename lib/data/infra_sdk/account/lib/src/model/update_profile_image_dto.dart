// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'update_profile_image_dto.g.dart';

/// UpdateProfileImageDTO
///
/// Properties:
/// * [imageUrl] - URL of the image to be uploaded.
@BuiltValue()
abstract class UpdateProfileImageDTO implements Built<UpdateProfileImageDTO, UpdateProfileImageDTOBuilder> {
  /// URL of the image to be uploaded.
  @BuiltValueField(wireName: r'imageUrl')
  String get imageUrl;

  UpdateProfileImageDTO._();

  factory UpdateProfileImageDTO([void updates(UpdateProfileImageDTOBuilder b)]) = _$UpdateProfileImageDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateProfileImageDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateProfileImageDTO> get serializer => _$UpdateProfileImageDTOSerializer();
}

class _$UpdateProfileImageDTOSerializer implements PrimitiveSerializer<UpdateProfileImageDTO> {
  @override
  final Iterable<Type> types = const [UpdateProfileImageDTO, _$UpdateProfileImageDTO];

  @override
  final String wireName = r'UpdateProfileImageDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateProfileImageDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'imageUrl';
    yield serializers.serialize(
      object.imageUrl,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateProfileImageDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UpdateProfileImageDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'imageUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.imageUrl = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  UpdateProfileImageDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateProfileImageDTOBuilder();
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

