import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/base_page.dart';
import 'package:swing_share/router/home_router.dart';

final homeVm = Provider.autoDispose((ref) => HomeViewModel(ref.read));

class HomeViewModel {
  HomeViewModel(this._read);
  final Reader _read;
  HomeRouter get _homeRouter => _read(homeRouterProvider);

  Future<void> pushDetailPage(Post post) async {
    _homeRouter.navigateTo(detailPath, args: post);
  }
}
