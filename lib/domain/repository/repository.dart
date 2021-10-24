import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart' as domain;
import 'package:swing_share/infra/model/post.dart';
import 'package:swing_share/infra/model/profile.dart';

abstract class Repository {
  /// user
  Future<void> setProfile(Profile profile);
  Stream<Profile> userStream();

  /// post
  Future<void> setPost(String body);
  Future<void> deletePost(String postId);
  Stream<List<Post>> userPostsStream();
  Stream<List<domain.Post>> allPostsStream();

  /// comment
  Future<void> setComment(
      String body, String postedProfileId, String postId, int count);
  Future<void> deleteComment(
      String postedProfileId, String postId, String commentId, int count);
  Stream<List<Comment>> postCommentsStream(String profileId, String postId);
  Stream<List<Comment>> userCommentStream();
}
