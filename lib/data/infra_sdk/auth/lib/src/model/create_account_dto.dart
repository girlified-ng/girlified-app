// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_account_dto.g.dart';

/// CreateAccountDTO
///
/// Properties:
/// * [email] - Email address of the user.
/// * [password] - Password for the user account.
/// * [firstName] - First name of the user.
/// * [lastName] - Last name of the user.
/// * [phone] - Phone number of the user.
@BuiltValue()
abstract class CreateAccountDTO implements Built<CreateAccountDTO, CreateAccountDTOBuilder> {
  /// Email address of the user.
  @BuiltValueField(wireName: r'email')
  String get email;

  /// Password for the user account.
  @BuiltValueField(wireName: r'password')
  String get password;

  /// First name of the user.
  @BuiltValueField(wireName: r'firstName')
  String get firstName;

  /// Last name of the user.
  @BuiltValueField(wireName: r'lastName')
  String get lastName;

  /// Phone number of the user.
  @BuiltValueField(wireName: r'phone')
  String? get phone;

  CreateAccountDTO._();

  factory CreateAccountDTO([void updates(CreateAccountDTOBuilder b)]) = _$CreateAccountDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateAccountDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateAccountDTO> get serializer => _$CreateAccountDTOSerializer();
}

class _$CreateAccountDTOSerializer implements PrimitiveSerializer<CreateAccountDTO> {
  @override
  final Iterable<Type> types = const [CreateAccountDTO, _$CreateAccountDTO];

  @override
  final String wireName = r'CreateAccountDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateAccountDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
    yield r'firstName';
    yield serializers.serialize(
      object.firstName,
      specifiedType: const FullType(String),
    );
    yield r'lastName';
    yield serializers.serialize(
      object.lastName,
      specifiedType: const FullType(String),
    );
    if (object.phone != null) {
      yield r'phone';
      yield serializers.serialize(
        object.phone,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateAccountDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CreateAccountDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        case r'firstName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.firstName = valueDes;
          break;
        case r'lastName':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.lastName = valueDes;
          break;
        case r'phone':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.phone = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateAccountDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateAccountDTOBuilder();
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

