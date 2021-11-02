import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/repository/repository.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/detail/state/detail_state.dart';

final detailVm =
    StateNotifierProvider.autoDispose<DetailViewModel, DetailState>(
        (ref) => DetailViewModel(ref.read));

class DetailViewModel extends StateNotifier<DetailState> {
  DetailViewModel(this._read) : super(const DetailState());
  final Reader _read;
  Repository get _repo => _read(repo);

  Future<void> fetch(String profileId, String postId) async {
    final items = await _repo.postComments(profileId, postId);
    state = state.copyWith(comments: items);
  }
}
