import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/base_page.dart';
import 'package:swing_share/presentation/home/state/home_state.dart';
import 'package:swing_share/router/home_router.dart';

final homeVm = StateNotifierProvider.autoDispose<HomeViewModel, HomeState>(
    (ref) => HomeViewModel(ref.read));

class HomeViewModel extends StateNotifier<HomeState> {
  HomeViewModel(this._read) : super(const HomeState());

  final Reader _read;
  HomeRouter get _homeRouter => _read(homeRouterProvider);
  Repository get _repo => _read(repo);

  Future<void> fetch({bool loadMore = false}) async {
    final items = await _repo.allPosts(
        lastPostDateTime: loadMore ? state.posts.last.createdAt : null);
    state = state.copyWith(
      posts: [if (loadMore) ...state.posts, ...items],
      hasNext: items.length >= 10,
    );
  }

  void refresh() => fetch();
  void loadMore() => fetch(loadMore: true);

  Future<void> pushDetailPage(Post post) async {
    _homeRouter.navigateTo(detailPath, args: post);
  }
}
