import 'package:swing_share/infra/model/post.dart';
import 'package:swing_share/infra/model/profile.dart';

abstract class Repository {
  Future<void> setPost();
  Future<void> deletePost();
  Stream<Profile> userStream();
  Stream<List<Post>> userPostsStream();
  Stream<List<Post>> allPostsStream();
}
