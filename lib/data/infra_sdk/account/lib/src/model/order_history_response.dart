// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:account_sdk/src/model/order_info.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_history_response.g.dart';

/// OrderHistoryResponse
///
/// Properties:
/// * [orders] - Order history.
/// * [totalPages] - Total number of pages.
/// * [hasNext] - Has next page.
@BuiltValue()
abstract class OrderHistoryResponse implements Built<OrderHistoryResponse, OrderHistoryResponseBuilder> {
  /// Order history.
  @BuiltValueField(wireName: r'orders')
  BuiltList<OrderInfo> get orders;

  /// Total number of pages.
  @BuiltValueField(wireName: r'totalPages')
  num get totalPages;

  /// Has next page.
  @BuiltValueField(wireName: r'hasNext')
  bool get hasNext;

  OrderHistoryResponse._();

  factory OrderHistoryResponse([void updates(OrderHistoryResponseBuilder b)]) = _$OrderHistoryResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderHistoryResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderHistoryResponse> get serializer => _$OrderHistoryResponseSerializer();
}

class _$OrderHistoryResponseSerializer implements PrimitiveSerializer<OrderHistoryResponse> {
  @override
  final Iterable<Type> types = const [OrderHistoryResponse, _$OrderHistoryResponse];

  @override
  final String wireName = r'OrderHistoryResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderHistoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'orders';
    yield serializers.serialize(
      object.orders,
      specifiedType: const FullType(BuiltList, [FullType(OrderInfo)]),
    );
    yield r'totalPages';
    yield serializers.serialize(
      object.totalPages,
      specifiedType: const FullType(num),
    );
    yield r'hasNext';
    yield serializers.serialize(
      object.hasNext,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderHistoryResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required OrderHistoryResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'orders':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(OrderInfo)]),
          ) as BuiltList<OrderInfo>;
          result.orders.replace(valueDes);
          break;
        case r'totalPages':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalPages = valueDes;
          break;
        case r'hasNext':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasNext = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderHistoryResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderHistoryResponseBuilder();
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

