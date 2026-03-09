// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_fcm_token_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateFCMTokenDTO extends UpdateFCMTokenDTO {
  @override
  final String fcmToken;

  factory _$UpdateFCMTokenDTO(
          [void Function(UpdateFCMTokenDTOBuilder)? updates]) =>
      (UpdateFCMTokenDTOBuilder()..update(updates))._build();

  _$UpdateFCMTokenDTO._({required this.fcmToken}) : super._();
  @override
  UpdateFCMTokenDTO rebuild(void Function(UpdateFCMTokenDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateFCMTokenDTOBuilder toBuilder() =>
      UpdateFCMTokenDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateFCMTokenDTO && fcmToken == other.fcmToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fcmToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateFCMTokenDTO')
          ..add('fcmToken', fcmToken))
        .toString();
  }
}

class UpdateFCMTokenDTOBuilder
    implements Builder<UpdateFCMTokenDTO, UpdateFCMTokenDTOBuilder> {
  _$UpdateFCMTokenDTO? _$v;

  String? _fcmToken;
  String? get fcmToken => _$this._fcmToken;
  set fcmToken(String? fcmToken) => _$this._fcmToken = fcmToken;

  UpdateFCMTokenDTOBuilder() {
    UpdateFCMTokenDTO._defaults(this);
  }

  UpdateFCMTokenDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fcmToken = $v.fcmToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateFCMTokenDTO other) {
    _$v = other as _$UpdateFCMTokenDTO;
  }

  @override
  void update(void Function(UpdateFCMTokenDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateFCMTokenDTO build() => _build();

  _$UpdateFCMTokenDTO _build() {
    final _$result = _$v ??
        _$UpdateFCMTokenDTO._(
          fcmToken: BuiltValueNullFieldError.checkNotNull(
              fcmToken, r'UpdateFCMTokenDTO', 'fcmToken'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
