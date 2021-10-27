import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/presentation/home/home_view_model.dart';

final entryVm = Provider.autoDispose((ref) => EntryViewModel(ref.read));

class EntryViewModel {
  EntryViewModel(this._read);
  final Reader _read;

  Future<void> post(String body, String? localImagePath) async {
    await _read(repo).setPost(body, localImagePath);
    _read(homeVm).refresh();
  }
}
