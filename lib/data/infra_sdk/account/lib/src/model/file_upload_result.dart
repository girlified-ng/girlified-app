// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'file_upload_result.g.dart';

/// FileUploadResult
///
/// Properties:
/// * [url] 
/// * [publicId] 
@BuiltValue()
abstract class FileUploadResult implements Built<FileUploadResult, FileUploadResultBuilder> {
  @BuiltValueField(wireName: r'url')
  String get url;

  @BuiltValueField(wireName: r'public_id')
  String get publicId;

  FileUploadResult._();

  factory FileUploadResult([void updates(FileUploadResultBuilder b)]) = _$FileUploadResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FileUploadResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FileUploadResult> get serializer => _$FileUploadResultSerializer();
}

class _$FileUploadResultSerializer implements PrimitiveSerializer<FileUploadResult> {
  @override
  final Iterable<Type> types = const [FileUploadResult, _$FileUploadResult];

  @override
  final String wireName = r'FileUploadResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FileUploadResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'url';
    yield serializers.serialize(
      object.url,
      specifiedType: const FullType(String),
    );
    yield r'public_id';
    yield serializers.serialize(
      object.publicId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FileUploadResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FileUploadResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'url':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.url = valueDes;
          break;
        case r'public_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.publicId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FileUploadResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FileUploadResultBuilder();
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

