// @dart=3.5
// @dart=3.5
// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'file_upload_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FileUploadResult extends FileUploadResult {
  @override
  final String url;
  @override
  final String publicId;

  factory _$FileUploadResult(
          [void Function(FileUploadResultBuilder)? updates]) =>
      (FileUploadResultBuilder()..update(updates))._build();

  _$FileUploadResult._({required this.url, required this.publicId}) : super._();
  @override
  FileUploadResult rebuild(void Function(FileUploadResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FileUploadResultBuilder toBuilder() =>
      FileUploadResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FileUploadResult &&
        url == other.url &&
        publicId == other.publicId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, publicId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FileUploadResult')
          ..add('url', url)
          ..add('publicId', publicId))
        .toString();
  }
}

class FileUploadResultBuilder
    implements Builder<FileUploadResult, FileUploadResultBuilder> {
  _$FileUploadResult? _$v;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _publicId;
  String? get publicId => _$this._publicId;
  set publicId(String? publicId) => _$this._publicId = publicId;

  FileUploadResultBuilder() {
    FileUploadResult._defaults(this);
  }

  FileUploadResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _url = $v.url;
      _publicId = $v.publicId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FileUploadResult other) {
    _$v = other as _$FileUploadResult;
  }

  @override
  void update(void Function(FileUploadResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FileUploadResult build() => _build();

  _$FileUploadResult _build() {
    final _$result = _$v ??
        _$FileUploadResult._(
          url: BuiltValueNullFieldError.checkNotNull(
              url, r'FileUploadResult', 'url'),
          publicId: BuiltValueNullFieldError.checkNotNull(
              publicId, r'FileUploadResult', 'publicId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
