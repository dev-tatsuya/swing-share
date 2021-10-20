import 'package:swing_share/domain/model/post.dart' as domain;
import 'package:swing_share/infra/model/post.dart';
import 'package:swing_share/infra/model/profile.dart';

abstract class Repository {
  /// user
  Future<void> setProfile(Profile profile);
  Stream<Profile> userStream();

  /// post
  Future<void> setPost(String body);
  Future<void> deletePost();
  Stream<List<Post>> userPostsStream();
  Stream<List<domain.Post>> allPostsStream();
}
