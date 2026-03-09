// @dart=3.5
// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'testimonial_info.g.dart';

/// TestimonialInfo
///
/// Properties:
/// * [id] - The ID of the testimonial
/// * [author] - The author of the testimonial
/// * [avatarUrl] - The avatar URL of the testimonial
/// * [age] - The age of the user
/// * [testimonial] - The testimonial
/// * [handle] - The handle of the user
/// * [platform] - The platform of the user
/// * [createdAt] - The created at date of the testimonial
@BuiltValue()
abstract class TestimonialInfo implements Built<TestimonialInfo, TestimonialInfoBuilder> {
  /// The ID of the testimonial
  @BuiltValueField(wireName: r'id')
  String? get id;

  /// The author of the testimonial
  @BuiltValueField(wireName: r'author')
  String? get author;

  /// The avatar URL of the testimonial
  @BuiltValueField(wireName: r'avatarUrl')
  String? get avatarUrl;

  /// The age of the user
  @BuiltValueField(wireName: r'age')
  String? get age;

  /// The testimonial
  @BuiltValueField(wireName: r'testimonial')
  String? get testimonial;

  /// The handle of the user
  @BuiltValueField(wireName: r'handle')
  String? get handle;

  /// The platform of the user
  @BuiltValueField(wireName: r'platform')
  String? get platform;

  /// The created at date of the testimonial
  @BuiltValueField(wireName: r'createdAt')
  DateTime? get createdAt;

  TestimonialInfo._();

  factory TestimonialInfo([void updates(TestimonialInfoBuilder b)]) = _$TestimonialInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TestimonialInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TestimonialInfo> get serializer => _$TestimonialInfoSerializer();
}

class _$TestimonialInfoSerializer implements PrimitiveSerializer<TestimonialInfo> {
  @override
  final Iterable<Type> types = const [TestimonialInfo, _$TestimonialInfo];

  @override
  final String wireName = r'TestimonialInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TestimonialInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.id != null) {
      yield r'id';
      yield serializers.serialize(
        object.id,
        specifiedType: const FullType(String),
      );
    }
    if (object.author != null) {
      yield r'author';
      yield serializers.serialize(
        object.author,
        specifiedType: const FullType(String),
      );
    }
    if (object.avatarUrl != null) {
      yield r'avatarUrl';
      yield serializers.serialize(
        object.avatarUrl,
        specifiedType: const FullType(String),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType(String),
      );
    }
    if (object.testimonial != null) {
      yield r'testimonial';
      yield serializers.serialize(
        object.testimonial,
        specifiedType: const FullType(String),
      );
    }
    if (object.handle != null) {
      yield r'handle';
      yield serializers.serialize(
        object.handle,
        specifiedType: const FullType(String),
      );
    }
    if (object.platform != null) {
      yield r'platform';
      yield serializers.serialize(
        object.platform,
        specifiedType: const FullType(String),
      );
    }
    if (object.createdAt != null) {
      yield r'createdAt';
      yield serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TestimonialInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TestimonialInfoBuilder result,
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
        case r'author':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.author = valueDes;
          break;
        case r'avatarUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.avatarUrl = valueDes;
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.age = valueDes;
          break;
        case r'testimonial':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.testimonial = valueDes;
          break;
        case r'handle':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.handle = valueDes;
          break;
        case r'platform':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.platform = valueDes;
          break;
        case r'createdAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TestimonialInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TestimonialInfoBuilder();
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

