// @dart=3.5
// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.5

part of 'testimonial_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TestimonialInfo extends TestimonialInfo {
  @override
  final String? id;
  @override
  final String? author;
  @override
  final String? avatarUrl;
  @override
  final String? age;
  @override
  final String? testimonial;
  @override
  final String? handle;
  @override
  final String? platform;
  @override
  final DateTime? createdAt;

  factory _$TestimonialInfo([void Function(TestimonialInfoBuilder)? updates]) =>
      (TestimonialInfoBuilder()..update(updates))._build();

  _$TestimonialInfo._(
      {this.id,
      this.author,
      this.avatarUrl,
      this.age,
      this.testimonial,
      this.handle,
      this.platform,
      this.createdAt})
      : super._();
  @override
  TestimonialInfo rebuild(void Function(TestimonialInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TestimonialInfoBuilder toBuilder() => TestimonialInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TestimonialInfo &&
        id == other.id &&
        author == other.author &&
        avatarUrl == other.avatarUrl &&
        age == other.age &&
        testimonial == other.testimonial &&
        handle == other.handle &&
        platform == other.platform &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, author.hashCode);
    _$hash = $jc(_$hash, avatarUrl.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, testimonial.hashCode);
    _$hash = $jc(_$hash, handle.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TestimonialInfo')
          ..add('id', id)
          ..add('author', author)
          ..add('avatarUrl', avatarUrl)
          ..add('age', age)
          ..add('testimonial', testimonial)
          ..add('handle', handle)
          ..add('platform', platform)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class TestimonialInfoBuilder
    implements Builder<TestimonialInfo, TestimonialInfoBuilder> {
  _$TestimonialInfo? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _author;
  String? get author => _$this._author;
  set author(String? author) => _$this._author = author;

  String? _avatarUrl;
  String? get avatarUrl => _$this._avatarUrl;
  set avatarUrl(String? avatarUrl) => _$this._avatarUrl = avatarUrl;

  String? _age;
  String? get age => _$this._age;
  set age(String? age) => _$this._age = age;

  String? _testimonial;
  String? get testimonial => _$this._testimonial;
  set testimonial(String? testimonial) => _$this._testimonial = testimonial;

  String? _handle;
  String? get handle => _$this._handle;
  set handle(String? handle) => _$this._handle = handle;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  TestimonialInfoBuilder() {
    TestimonialInfo._defaults(this);
  }

  TestimonialInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _author = $v.author;
      _avatarUrl = $v.avatarUrl;
      _age = $v.age;
      _testimonial = $v.testimonial;
      _handle = $v.handle;
      _platform = $v.platform;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TestimonialInfo other) {
    _$v = other as _$TestimonialInfo;
  }

  @override
  void update(void Function(TestimonialInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TestimonialInfo build() => _build();

  _$TestimonialInfo _build() {
    final _$result = _$v ??
        _$TestimonialInfo._(
          id: id,
          author: author,
          avatarUrl: avatarUrl,
          age: age,
          testimonial: testimonial,
          handle: handle,
          platform: platform,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
