import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/profile.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const Post._();
  const factory Post({
    required String? id,
    required Profile profile,
    required String body,
    required DateTime? createdAt,
    required int commentCount,
    required String? imagePath,
    required String? videoPath,
  }) = _Post;

  int get incrementedCount => commentCount + 1;
  int get decrementedCount => commentCount - 1;
}
