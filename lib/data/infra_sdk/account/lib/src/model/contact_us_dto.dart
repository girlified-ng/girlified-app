// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'contact_us_dto.g.dart';

/// ContactUsDTO
///
/// Properties:
/// * [name] - The name of the user
/// * [email] - The email of the user
/// * [subject] - The subject of the message
/// * [message] - The message from the user
@BuiltValue()
abstract class ContactUsDTO implements Built<ContactUsDTO, ContactUsDTOBuilder> {
  /// The name of the user
  @BuiltValueField(wireName: r'name')
  String get name;

  /// The email of the user
  @BuiltValueField(wireName: r'email')
  String get email;

  /// The subject of the message
  @BuiltValueField(wireName: r'subject')
  String get subject;

  /// The message from the user
  @BuiltValueField(wireName: r'message')
  String get message;

  ContactUsDTO._();

  factory ContactUsDTO([void updates(ContactUsDTOBuilder b)]) = _$ContactUsDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ContactUsDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ContactUsDTO> get serializer => _$ContactUsDTOSerializer();
}

class _$ContactUsDTOSerializer implements PrimitiveSerializer<ContactUsDTO> {
  @override
  final Iterable<Type> types = const [ContactUsDTO, _$ContactUsDTO];

  @override
  final String wireName = r'ContactUsDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ContactUsDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'subject';
    yield serializers.serialize(
      object.subject,
      specifiedType: const FullType(String),
    );
    yield r'message';
    yield serializers.serialize(
      object.message,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ContactUsDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ContactUsDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'subject':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.subject = valueDes;
          break;
        case r'message':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.message = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ContactUsDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ContactUsDTOBuilder();
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

