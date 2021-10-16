import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';

part 'user_posts.freezed.dart';

@freezed
abstract class UserPosts with _$UserPosts {
  const factory UserPosts({
    required Profile profile,
    required List<Post> posts,
  }) = _UserPosts;
}
