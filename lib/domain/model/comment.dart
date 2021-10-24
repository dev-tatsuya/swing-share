import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/profile.dart';

part 'comment.freezed.dart';

@freezed
abstract class Comment with _$Comment {
  const Comment._();
  const factory Comment({
    required String? id,
    required Profile profile,
    required String body,
    required DateTime? createdAt,
  }) = _Comment;
}
