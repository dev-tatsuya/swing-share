import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart' as domain;
import 'package:swing_share/domain/model/profile.dart' as domain;
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/model/post.dart';
import 'package:swing_share/infra/model/profile.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';
import 'package:swing_share/infra/service/firestore/api_path.dart';
import 'package:swing_share/infra/service/firestore/firestore_service.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';

String get documentIdFromCurrentDate => DateTime.now().toIso8601String();

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
  Stream<List<domain.Post>> allPostsStream() {
    return _service.collectionGroupStream<domain.Post>(
      path: 'posts',
      builder: (data, documentId) {
        final model = Post.fromMap(data, documentId);
        final author = model.author;
        final name = author?['name'] ?? defaultName;
        final thumbnailPath = author?['thumbnailPath'] ?? defaultPhotoUrl;

        return domain.Post(
            profile: domain.Profile(name: name, thumbnailPath: thumbnailPath),
            body: model.body ?? '',
            createdAt: model.createdAt);
      },
      sort: (lhs, rhs) => rhs.createdAt!.compareTo(lhs.createdAt!),
    );
  }

  @override
  Stream<List<Post>> userPostsStream() {
    return _service.collectionStream<Post>(
      path: APIPath.posts(uid!),
      builder: (data, documentId) => Post.fromMap(data, documentId),
      sort: (lhs, rhs) => rhs.createdAt!.compareTo(lhs.createdAt!),
    );
  }

  @override
  Future<void> setProfile(Profile profile) async {
    _service.setData(path: APIPath.user(uid!), data: profile.toMap());
  }

  @override
  Future<void> setPost(String body) async {
    final profile = await _service.documentFuture<Profile>(
      path: APIPath.user(uid!),
      builder: (data, documentId) => Profile.fromMap(data, documentId),
    );

    _service.setData(
      path: APIPath.post(uid!, documentIdFromCurrentDate),
      data: <String, dynamic>{
        'author': <String, dynamic>{
          'name': profile.name,
          'ref': 'users/$uid',
          'thumbnailPath': profile.thumbnailPath,
        },
        'body': body,
        'createdAt': DateTime.now(),
      },
    );
  }

  @override
  Stream<Profile> userStream() {
    return _service.documentStream(
      path: APIPath.user(uid!),
      builder: (data, documentId) => Profile.fromMap(data, documentId),
    );
  }
}
