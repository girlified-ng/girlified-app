// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:account_sdk/src/model/notification_info.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'notifications_response.g.dart';

/// NotificationsResponse
///
/// Properties:
/// * [notifications] 
/// * [totalPages] 
/// * [hasNextPage] 
@BuiltValue()
abstract class NotificationsResponse implements Built<NotificationsResponse, NotificationsResponseBuilder> {
  @BuiltValueField(wireName: r'notifications')
  BuiltList<NotificationInfo> get notifications;

  @BuiltValueField(wireName: r'totalPages')
  num get totalPages;

  @BuiltValueField(wireName: r'hasNextPage')
  bool get hasNextPage;

  NotificationsResponse._();

  factory NotificationsResponse([void updates(NotificationsResponseBuilder b)]) = _$NotificationsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NotificationsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NotificationsResponse> get serializer => _$NotificationsResponseSerializer();
}

class _$NotificationsResponseSerializer implements PrimitiveSerializer<NotificationsResponse> {
  @override
  final Iterable<Type> types = const [NotificationsResponse, _$NotificationsResponse];

  @override
  final String wireName = r'NotificationsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NotificationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'notifications';
    yield serializers.serialize(
      object.notifications,
      specifiedType: const FullType(BuiltList, [FullType(NotificationInfo)]),
    );
    yield r'totalPages';
    yield serializers.serialize(
      object.totalPages,
      specifiedType: const FullType(num),
    );
    yield r'hasNextPage';
    yield serializers.serialize(
      object.hasNextPage,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    NotificationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NotificationsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'notifications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(NotificationInfo)]),
          ) as BuiltList<NotificationInfo>;
          result.notifications.replace(valueDes);
          break;
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPages = valueDes;
          break;
        case r'hasNextPage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasNextPage = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  NotificationsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotificationsResponseBuilder();
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

