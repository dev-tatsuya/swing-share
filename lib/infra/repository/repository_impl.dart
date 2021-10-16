import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/model/post.dart';
import 'package:swing_share/infra/model/profile.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';
import 'package:swing_share/infra/service/firestore/api_path.dart';
import 'package:swing_share/infra/service/firestore/firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

final repo = Provider<Repository>((ref) {
  final auth = ref.watch(authService);

  return RepositoryImpl(uid: auth.currentUser?.uid);
});

class RepositoryImpl implements Repository {
  RepositoryImpl({this.uid});
  final String? uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> deletePost() {
    // TODO: implement deletePost
    throw UnimplementedError();
  }

  @override
  Stream<List<Post>> allPostsStream() {
    return _service.collectionStream<Post>(
      path: APIPath.posts(uid!),
      builder: (data, documentId) => Post.fromMap(data, documentId),
    );
  }

  @override
  Stream<List<Post>> userPostsStream() {
    return _service.collectionStream<Post>(
      path: APIPath.posts(uid!),
      builder: (data, documentId) => Post.fromMap(data, documentId),
    );
  }

  @override
  Future<void> setPost() {
    // TODO: implement setPost
    throw UnimplementedError();
  }

  @override
  Stream<Profile> userStream() {
    return _service.documentStream(
      path: APIPath.user(uid!),
      builder: (data, documentId) => Profile.fromMap(data, documentId),
    );
  }
}
