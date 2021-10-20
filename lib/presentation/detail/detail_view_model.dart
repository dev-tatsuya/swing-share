import 'package:hooks_riverpod/hooks_riverpod.dart';

final detailVm = Provider.autoDispose((ref) => DetailViewModel(ref.read));

class DetailViewModel {
  DetailViewModel(this._read);
  final Reader _read;
}
