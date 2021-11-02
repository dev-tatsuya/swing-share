import 'package:swing_share/domain/model/comment.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/infra/model/profile.dart' as model;

abstract class Repository {
  /// user
  Future<void> setProfile(model.Profile profile);
  Future<Profile> profile();

  /// post
  Future<void> setPost(
      String body, String? localImagePath, String? localVideoPath);
  Future<void> deletePost(String postId);
  Future<List<Post>> myPosts({DateTime? lastPostDateTime});
  Future<List<Post>> allPosts({DateTime? lastPostDateTime});

  /// comment
  Future<void> setComment(
      String body, String postedProfileId, String postId, int count);
  Future<void> deleteComment(
      String postedProfileId, String postId, String commentId, int count);
  Future<List<Comment>> postComments(String profileId, String postId);
  Future<List<Comment>> userComments();
}
