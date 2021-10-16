import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/profile.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required Profile profile,
    required String body,
    required DateTime? createdAt,
  }) = _Post;
}