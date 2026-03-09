// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'delete_account_dto.g.dart';

/// DeleteAccountDTO
///
/// Properties:
/// * [password] - Current account password.
@BuiltValue()
abstract class DeleteAccountDTO implements Built<DeleteAccountDTO, DeleteAccountDTOBuilder> {
  /// Current account password.
  @BuiltValueField(wireName: r'password')
  String get password;

  DeleteAccountDTO._();

  factory DeleteAccountDTO([void updates(DeleteAccountDTOBuilder b)]) = _$DeleteAccountDTO;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeleteAccountDTOBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeleteAccountDTO> get serializer => _$DeleteAccountDTOSerializer();
}

class _$DeleteAccountDTOSerializer implements PrimitiveSerializer<DeleteAccountDTO> {
  @override
  final Iterable<Type> types = const [DeleteAccountDTO, _$DeleteAccountDTO];

  @override
  final String wireName = r'DeleteAccountDTO';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeleteAccountDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'password';
    yield serializers.serialize(
      object.password,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DeleteAccountDTO object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeleteAccountDTOBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'password':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.password = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeleteAccountDTO deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeleteAccountDTOBuilder();
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

