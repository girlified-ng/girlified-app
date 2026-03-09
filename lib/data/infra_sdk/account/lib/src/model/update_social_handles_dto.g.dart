// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_social_handles_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateSocialHandlesDTO extends UpdateSocialHandlesDTO {
  @override
  final String xHandle;
  @override
  final String instagramHandle;
  @override
  final String tiktokHandle;
  @override
  final String snapchatHandle;

  factory _$UpdateSocialHandlesDTO(
          [void Function(UpdateSocialHandlesDTOBuilder)? updates]) =>
      (UpdateSocialHandlesDTOBuilder()..update(updates))._build();

  _$UpdateSocialHandlesDTO._(
      {required this.xHandle,
      required this.instagramHandle,
      required this.tiktokHandle,
      required this.snapchatHandle})
      : super._();
  @override
  UpdateSocialHandlesDTO rebuild(
          void Function(UpdateSocialHandlesDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateSocialHandlesDTOBuilder toBuilder() =>
      UpdateSocialHandlesDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateSocialHandlesDTO &&
        xHandle == other.xHandle &&
        instagramHandle == other.instagramHandle &&
        tiktokHandle == other.tiktokHandle &&
        snapchatHandle == other.snapchatHandle;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, xHandle.hashCode);
    _$hash = $jc(_$hash, instagramHandle.hashCode);
    _$hash = $jc(_$hash, tiktokHandle.hashCode);
    _$hash = $jc(_$hash, snapchatHandle.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateSocialHandlesDTO')
          ..add('xHandle', xHandle)
          ..add('instagramHandle', instagramHandle)
          ..add('tiktokHandle', tiktokHandle)
          ..add('snapchatHandle', snapchatHandle))
        .toString();
  }
}

class UpdateSocialHandlesDTOBuilder
    implements Builder<UpdateSocialHandlesDTO, UpdateSocialHandlesDTOBuilder> {
  _$UpdateSocialHandlesDTO? _$v;

  String? _xHandle;
  String? get xHandle => _$this._xHandle;
  set xHandle(String? xHandle) => _$this._xHandle = xHandle;

  String? _instagramHandle;
  String? get instagramHandle => _$this._instagramHandle;
  set instagramHandle(String? instagramHandle) =>
      _$this._instagramHandle = instagramHandle;

  String? _tiktokHandle;
  String? get tiktokHandle => _$this._tiktokHandle;
  set tiktokHandle(String? tiktokHandle) => _$this._tiktokHandle = tiktokHandle;

  String? _snapchatHandle;
  String? get snapchatHandle => _$this._snapchatHandle;
  set snapchatHandle(String? snapchatHandle) =>
      _$this._snapchatHandle = snapchatHandle;

  UpdateSocialHandlesDTOBuilder() {
    UpdateSocialHandlesDTO._defaults(this);
  }

  UpdateSocialHandlesDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _xHandle = $v.xHandle;
      _instagramHandle = $v.instagramHandle;
      _tiktokHandle = $v.tiktokHandle;
      _snapchatHandle = $v.snapchatHandle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateSocialHandlesDTO other) {
    _$v = other as _$UpdateSocialHandlesDTO;
  }

  @override
  void update(void Function(UpdateSocialHandlesDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateSocialHandlesDTO build() => _build();

  _$UpdateSocialHandlesDTO _build() {
    final _$result = _$v ??
        _$UpdateSocialHandlesDTO._(
          xHandle: BuiltValueNullFieldError.checkNotNull(
              xHandle, r'UpdateSocialHandlesDTO', 'xHandle'),
          instagramHandle: BuiltValueNullFieldError.checkNotNull(
              instagramHandle, r'UpdateSocialHandlesDTO', 'instagramHandle'),
          tiktokHandle: BuiltValueNullFieldError.checkNotNull(
              tiktokHandle, r'UpdateSocialHandlesDTO', 'tiktokHandle'),
          snapchatHandle: BuiltValueNullFieldError.checkNotNull(
              snapchatHandle, r'UpdateSocialHandlesDTO', 'snapchatHandle'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
