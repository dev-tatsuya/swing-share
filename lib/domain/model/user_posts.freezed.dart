// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

part of 'user_posts.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UserPostsTearOff {
  const _$UserPostsTearOff();

  _UserPosts call({required Profile profile, required List<Post> posts}) {
    return _UserPosts(
      profile: profile,
      posts: posts,
    );
  }
}

/// @nodoc
const $UserPosts = _$UserPostsTearOff();

/// @nodoc
mixin _$UserPosts {
  Profile get profile => throw _privateConstructorUsedError;
  List<Post> get posts => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserPostsCopyWith<UserPosts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserPostsCopyWith<$Res> {
  factory $UserPostsCopyWith(UserPosts value, $Res Function(UserPosts) then) =
      _$UserPostsCopyWithImpl<$Res>;
  $Res call({Profile profile, List<Post> posts});

  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class _$UserPostsCopyWithImpl<$Res> implements $UserPostsCopyWith<$Res> {
  _$UserPostsCopyWithImpl(this._value, this._then);

  final UserPosts _value;
  // ignore: unused_field
  final $Res Function(UserPosts) _then;

  @override
  $Res call({
    Object? profile = freezed,
    Object? posts = freezed,
  }) {
    return _then(_value.copyWith(
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      posts: posts == freezed
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }

  @override
  $ProfileCopyWith<$Res> get profile {
    return $ProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value));
    });
  }
}

/// @nodoc
abstract class _$UserPostsCopyWith<$Res> implements $UserPostsCopyWith<$Res> {
  factory _$UserPostsCopyWith(
          _UserPosts value, $Res Function(_UserPosts) then) =
      __$UserPostsCopyWithImpl<$Res>;
  @override
  $Res call({Profile profile, List<Post> posts});

  @override
  $ProfileCopyWith<$Res> get profile;
}

/// @nodoc
class __$UserPostsCopyWithImpl<$Res> extends _$UserPostsCopyWithImpl<$Res>
    implements _$UserPostsCopyWith<$Res> {
  __$UserPostsCopyWithImpl(_UserPosts _value, $Res Function(_UserPosts) _then)
      : super(_value, (v) => _then(v as _UserPosts));

  @override
  _UserPosts get _value => super._value as _UserPosts;

  @override
  $Res call({
    Object? profile = freezed,
    Object? posts = freezed,
  }) {
    return _then(_UserPosts(
      profile: profile == freezed
          ? _value.profile
          : profile // ignore: cast_nullable_to_non_nullable
              as Profile,
      posts: posts == freezed
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as List<Post>,
    ));
  }
}

/// @nodoc

class _$_UserPosts implements _UserPosts {
  const _$_UserPosts({required this.profile, required this.posts});

  @override
  final Profile profile;
  @override
  final List<Post> posts;

  @override
  String toString() {
    return 'UserPosts(profile: $profile, posts: $posts)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserPosts &&
            (identical(other.profile, profile) ||
                const DeepCollectionEquality()
                    .equals(other.profile, profile)) &&
            (identical(other.posts, posts) ||
                const DeepCollectionEquality().equals(other.posts, posts)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(profile) ^
      const DeepCollectionEquality().hash(posts);

  @JsonKey(ignore: true)
  @override
  _$UserPostsCopyWith<_UserPosts> get copyWith =>
      __$UserPostsCopyWithImpl<_UserPosts>(this, _$identity);
}

abstract class _UserPosts implements UserPosts {
  const factory _UserPosts(
      {required Profile profile, required List<Post> posts}) = _$_UserPosts;

  @override
  Profile get profile => throw _privateConstructorUsedError;
  @override
  List<Post> get posts => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserPostsCopyWith<_UserPosts> get copyWith =>
      throw _privateConstructorUsedError;
}
