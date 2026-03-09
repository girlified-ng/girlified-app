// @dart=3.5
//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'account_info.g.dart';

/// AccountInfo
///
/// Properties:
/// * [id] 
/// * [firstName] 
/// * [lastName] 
/// * [phone] 
/// * [email] 
/// * [state] 
/// * [stateArea] 
/// * [profilePhoto] 
/// * [accountType] 
/// * [status] 
/// * [fcmToken] 
/// * [referralCode] 
@BuiltValue()
abstract class AccountInfo implements Built<AccountInfo, AccountInfoBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'firstName')
  String get firstName;

  @BuiltValueField(wireName: r'lastName')
  String get lastName;

  @BuiltValueField(wireName: r'phone')
  String get phone;

  @BuiltValueField(wireName: r'email')
  String get email;

  @BuiltValueField(wireName: r'state')
  String get state;

  @BuiltValueField(wireName: r'stateArea')
  String get stateArea;

  @BuiltValueField(wireName: r'profilePhoto')
  String get profilePhoto;

  @BuiltValueField(wireName: r'accountType')
  AccountInfoAccountTypeEnum get accountType;
  // enum accountTypeEnum {  individual,  admin,  super_admin,  system,  };

  @BuiltValueField(wireName: r'status')
  AccountInfoStatusEnum get status;
  // enum statusEnum {  pending,  active,  inactive,  shadow_banned,  disabled,  };

  @BuiltValueField(wireName: r'fcmToken')
  String get fcmToken;

  @BuiltValueField(wireName: r'referralCode')
  String get referralCode;

  AccountInfo._();

  factory AccountInfo([void updates(AccountInfoBuilder b)]) = _$AccountInfo;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AccountInfoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AccountInfo> get serializer => _$AccountInfoSerializer();
}

class _$AccountInfoSerializer implements PrimitiveSerializer<AccountInfo> {
  @override
  final Iterable<Type> types = const [AccountInfo, _$AccountInfo];

  @override
  final String wireName = r'AccountInfo';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AccountInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
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
    yield r'phone';
    yield serializers.serialize(
      object.phone,
      specifiedType: const FullType(String),
    );
    yield r'email';
    yield serializers.serialize(
      object.email,
      specifiedType: const FullType(String),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(String),
    );
    yield r'stateArea';
    yield serializers.serialize(
      object.stateArea,
      specifiedType: const FullType(String),
    );
    yield r'profilePhoto';
    yield serializers.serialize(
      object.profilePhoto,
      specifiedType: const FullType(String),
    );
    yield r'accountType';
    yield serializers.serialize(
      object.accountType,
      specifiedType: const FullType(AccountInfoAccountTypeEnum),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(AccountInfoStatusEnum),
    );
    yield r'fcmToken';
    yield serializers.serialize(
      object.fcmToken,
      specifiedType: const FullType(String),
    );
    yield r'referralCode';
    yield serializers.serialize(
      object.referralCode,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AccountInfo object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AccountInfoBuilder result,
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
        case r'email':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.email = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.state = valueDes;
          break;
        case r'stateArea':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.stateArea = valueDes;
          break;
        case r'profilePhoto':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.profilePhoto = valueDes;
          break;
        case r'accountType':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountInfoAccountTypeEnum),
          ) as AccountInfoAccountTypeEnum;
          result.accountType = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AccountInfoStatusEnum),
          ) as AccountInfoStatusEnum;
          result.status = valueDes;
          break;
        case r'fcmToken':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.fcmToken = valueDes;
          break;
        case r'referralCode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.referralCode = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AccountInfo deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AccountInfoBuilder();
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

class AccountInfoAccountTypeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'individual')
  static const AccountInfoAccountTypeEnum individual = _$accountInfoAccountTypeEnum_individual;
  @BuiltValueEnumConst(wireName: r'admin')
  static const AccountInfoAccountTypeEnum admin = _$accountInfoAccountTypeEnum_admin;
  @BuiltValueEnumConst(wireName: r'super_admin')
  static const AccountInfoAccountTypeEnum superAdmin = _$accountInfoAccountTypeEnum_superAdmin;
  @BuiltValueEnumConst(wireName: r'system')
  static const AccountInfoAccountTypeEnum system = _$accountInfoAccountTypeEnum_system;

  static Serializer<AccountInfoAccountTypeEnum> get serializer => _$accountInfoAccountTypeEnumSerializer;

  const AccountInfoAccountTypeEnum._(String name): super(name);

  static BuiltSet<AccountInfoAccountTypeEnum> get values => _$accountInfoAccountTypeEnumValues;
  static AccountInfoAccountTypeEnum valueOf(String name) => _$accountInfoAccountTypeEnumValueOf(name);
}

class AccountInfoStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'pending')
  static const AccountInfoStatusEnum pending = _$accountInfoStatusEnum_pending;
  @BuiltValueEnumConst(wireName: r'active')
  static const AccountInfoStatusEnum active = _$accountInfoStatusEnum_active;
  @BuiltValueEnumConst(wireName: r'inactive')
  static const AccountInfoStatusEnum inactive = _$accountInfoStatusEnum_inactive;
  @BuiltValueEnumConst(wireName: r'shadow_banned')
  static const AccountInfoStatusEnum shadowBanned = _$accountInfoStatusEnum_shadowBanned;
  @BuiltValueEnumConst(wireName: r'disabled')
  static const AccountInfoStatusEnum disabled = _$accountInfoStatusEnum_disabled;

  static Serializer<AccountInfoStatusEnum> get serializer => _$accountInfoStatusEnumSerializer;

  const AccountInfoStatusEnum._(String name): super(name);

  static BuiltSet<AccountInfoStatusEnum> get values => _$accountInfoStatusEnumValues;
  static AccountInfoStatusEnum valueOf(String name) => _$accountInfoStatusEnumValueOf(name);
}

