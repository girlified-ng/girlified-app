// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'update_profile_image_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateProfileImageDTO extends UpdateProfileImageDTO {
  @override
  final String imageUrl;

  factory _$UpdateProfileImageDTO(
          [void Function(UpdateProfileImageDTOBuilder)? updates]) =>
      (UpdateProfileImageDTOBuilder()..update(updates))._build();

  _$UpdateProfileImageDTO._({required this.imageUrl}) : super._();
  @override
  UpdateProfileImageDTO rebuild(
          void Function(UpdateProfileImageDTOBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateProfileImageDTOBuilder toBuilder() =>
      UpdateProfileImageDTOBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateProfileImageDTO && imageUrl == other.imageUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, imageUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateProfileImageDTO')
          ..add('imageUrl', imageUrl))
        .toString();
  }
}

class UpdateProfileImageDTOBuilder
    implements Builder<UpdateProfileImageDTO, UpdateProfileImageDTOBuilder> {
  _$UpdateProfileImageDTO? _$v;

  String? _imageUrl;
  String? get imageUrl => _$this._imageUrl;
  set imageUrl(String? imageUrl) => _$this._imageUrl = imageUrl;

  UpdateProfileImageDTOBuilder() {
    UpdateProfileImageDTO._defaults(this);
  }

  UpdateProfileImageDTOBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _imageUrl = $v.imageUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateProfileImageDTO other) {
    _$v = other as _$UpdateProfileImageDTO;
  }

  @override
  void update(void Function(UpdateProfileImageDTOBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateProfileImageDTO build() => _build();

  _$UpdateProfileImageDTO _build() {
    final _$result = _$v ??
        _$UpdateProfileImageDTO._(
          imageUrl: BuiltValueNullFieldError.checkNotNull(
              imageUrl, r'UpdateProfileImageDTO', 'imageUrl'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
