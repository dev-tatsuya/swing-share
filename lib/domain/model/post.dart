import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/profile.dart';

part 'post.freezed.dart';

@freezed
abstract class Post with _$Post {
  const factory Post({
    required String? id,
    required Profile profile,
    required String body,
    required DateTime? createdAt,
    required int commentCount,
  }) = _Post;
}
