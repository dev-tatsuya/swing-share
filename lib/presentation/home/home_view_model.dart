import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rxdart/rxdart.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/base_page.dart';
import 'package:swing_share/router/home_router.dart';

final homeVm = Provider.autoDispose((ref) => HomeViewModel(ref.read));

class HomeViewModel {
  HomeViewModel(this._read) {
    postController = BehaviorSubject.seeded([]);
    hasNextController = BehaviorSubject.seeded(false);
  }

  final Reader _read;
  HomeRouter get _homeRouter => _read(homeRouterProvider);

  List<DocumentSnapshot> documentList = [];
  late BehaviorSubject<List<DocumentSnapshot>> postController;
  Stream<List<DocumentSnapshot>> get postsStream => postController.stream;

  late BehaviorSubject<bool> hasNextController;
  Stream<bool> get hasNextStream => hasNextController.stream;

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
    postController.sink.add(documentList);
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
    postController.sink.add(documentList);
  }

  void dispose() {
    postController.close();
    hasNextController.close();
  }

  Future<void> pushDetailPage(Post post) async {
    _homeRouter.navigateTo(detailPath, args: post);
  }
}
