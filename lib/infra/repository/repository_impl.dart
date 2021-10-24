import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/comment.dart' as domain;
import 'package:swing_share/domain/model/post.dart' as domain;
import 'package:swing_share/domain/model/profile.dart' as domain;
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/model/comment.dart';
import 'package:swing_share/infra/model/post.dart';
import 'package:swing_share/infra/model/profile.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';
import 'package:swing_share/infra/service/firestore/api_path.dart';
import 'package:swing_share/infra/service/firestore/firestore_service.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';

String get documentIdFromCurrentDate => DateTime.now().toIso8601String();

final repo = Provider.autoDispose<Repository>((ref) {
  final auth = ref.watch(authStateChangesProvider);

  if (auth.asData?.value?.uid != null) {
    return RepositoryImpl(uid: auth.asData!.value!.uid);
  }

  return RepositoryImpl();
});

class RepositoryImpl implements Repository {
  RepositoryImpl({this.uid});
  final String? uid;

  final _service = FirestoreService.instance;

  @override
  Future<void> deletePost(String postId) async {
    await _service.deleteData(path: APIPath.post(uid!, postId));
  }

  @override
  Stream<List<domain.Post>> allPostsStream() {
    return _service.collectionGroupStream<domain.Post>(
      path: 'posts',
      builder: (data, documentId) {
        final model = Post.fromMap(data, documentId);
        final author = model.author;
        final id = author?['ref'].split('/')[1] ?? '';
        final name = author?['name'] ?? defaultName;
        final thumbnailPath = author?['thumbnailPath'] ?? defaultPhotoUrl;

        return domain.Post(
          id: model.id,
          profile:
              domain.Profile(id: id, name: name, thumbnailPath: thumbnailPath),
          body: model.body ?? '',
          createdAt: model.createdAt,
          commentCount: model.commentCount,
        );
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
    await _service.setData(
        path: APIPath.user(profile.id!), data: profile.toMap());
  }

  @override
  Future<void> setPost(String body) async {
    final profile = await _service.documentFuture<Profile>(
      path: APIPath.user(uid!),
      builder: (data, documentId) => Profile.fromMap(data, documentId),
    );

    await _service.setData(
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

  @override
  Future<void> setComment(
      String body, String postedProfileId, String postId, int count) async {
    final profile = await _service.documentFuture<Profile>(
      path: APIPath.user(uid!),
      builder: (data, documentId) => Profile.fromMap(data, documentId),
    );

    await _service.setData(
      path: APIPath.comment(postedProfileId, postId, documentIdFromCurrentDate),
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

    await _updateCommentCount(postedProfileId, postId, count);
  }

  Future<void> _updateCommentCount(
      String postedProfileId, String postId, int count) async {
    await _service.updateData(
      path: APIPath.post(postedProfileId, postId),
      data: <String, dynamic>{'commentCount': count},
    );
  }

  @override
  Future<void> deleteComment(String postedProfileId, String postId,
      String commentId, int count) async {
    await _service.deleteData(
        path: APIPath.comment(postedProfileId, postId, commentId));
    await _updateCommentCount(postedProfileId, postId, count);
  }

  @override
  Stream<List<domain.Comment>> postCommentsStream(
      String profileId, String postId) {
    return _service.collectionStream<domain.Comment>(
      path: APIPath.comments(profileId, postId),
      builder: (data, documentId) =>
          Comment.fromMap(data, documentId).toEntity(),
      sort: (lhs, rhs) => lhs.createdAt!.compareTo(rhs.createdAt!),
    );
  }

  @override
  Stream<List<domain.Comment>> userCommentStream() {
    // TODO: implement userCommentStream
    throw UnimplementedError();
  }
}
