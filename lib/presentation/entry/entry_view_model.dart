import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';

final entryVm = Provider.autoDispose((ref) => EntryViewModel(ref.read));

class EntryViewModel {
  EntryViewModel(this._read);
  final Reader _read;

  Future<void> post(String body) async {
    _read(repo).setPost(body);
  }
}
