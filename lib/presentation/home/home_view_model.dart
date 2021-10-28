import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/infra/model/post.dart' as model;
import 'package:swing_share/presentation/base_page.dart';
import 'package:swing_share/router/home_router.dart';

final homeVm = Provider.autoDispose((ref) => HomeViewModel(ref.read));

class HomeViewModel {
  HomeViewModel(this._read) {
    documentListController = BehaviorSubject.seeded([]);
    postController = BehaviorSubject.seeded([]);
    hasNextController = BehaviorSubject.seeded(false);
  }

  final Reader _read;
  HomeRouter get _homeRouter => _read(homeRouterProvider);

  List<DocumentSnapshot> documentList = [];
  late BehaviorSubject<List<DocumentSnapshot>> documentListController;
  late BehaviorSubject<List<Post>> postController;
  Stream<List<DocumentSnapshot>> get documentListStream =>
      documentListController.stream;
  Stream<List<Post>> get postStream => postController.stream;

  late BehaviorSubject<bool> hasNextController;
  Stream<bool> get hasNextStream => hasNextController.stream;

  final storage = FirebaseStorage.instance;

  Future<void> init() async {
    final initList = (await FirebaseFirestore.instance
            .collectionGroup('posts')
            .orderBy('createdAt', descending: true)
            .limit(10)
            .get())
        .docs;
    final hasNext = initList.length >= 10;
    hasNextController.sink.add(hasNext);

    documentList.clear();
    documentList.addAll(initList);
    documentListController.sink.add(documentList);

    final posts = documentList
        .map((e) => model.Post.fromMap(e.data() as Map<String, dynamic>, e.id)
            .toEntity())
        .toList();

    final convertedList = <Post>[];
    await Future.forEach(posts, (Post e) async {
      String? imageStoragePath;
      if (e.imagePath != null) {
        imageStoragePath = await storage.ref(e.imagePath).getDownloadURL();
      }

      String? videoStoragePath;
      if (e.videoPath != null) {
        videoStoragePath = await storage.ref(e.videoPath).getDownloadURL();
      }

      convertedList.add(
          e.copyWith(imagePath: imageStoragePath, videoPath: videoStoragePath));
    });

    postController.sink.add(convertedList);
  }

  void refresh() => init();

  Future<void> loadMore() async {
    final loadList = (await FirebaseFirestore.instance
            .collectionGroup('posts')
            .orderBy('createdAt', descending: true)
            .startAfterDocument(documentList[documentList.length - 1])
            .limit(10)
            .get())
        .docs;
    final hasNext = loadList.length >= 10;
    hasNextController.sink.add(hasNext);

    documentList.addAll(loadList);
    documentListController.sink.add(documentList);

    final posts = documentList
        .map((e) => model.Post.fromMap(e.data() as Map<String, dynamic>, e.id)
            .toEntity())
        .toList();

    final convertedList = <Post>[];
    await Future.forEach(posts, (Post e) async {
      String? imageStoragePath;
      if (e.imagePath != null) {
        imageStoragePath = await storage.ref(e.imagePath).getDownloadURL();
      }

      String? videoStoragePath;
      if (e.videoPath != null) {
        videoStoragePath = await storage.ref(e.videoPath).getDownloadURL();
      }

      convertedList.add(
          e.copyWith(imagePath: imageStoragePath, videoPath: videoStoragePath));
    });

    postController.sink.add(convertedList);
  }

  void dispose() {
    documentListController.close();
    hasNextController.close();
  }

  Future<void> pushDetailPage(Post post) async {
    _homeRouter.navigateTo(detailPath, args: post);
  }
}
