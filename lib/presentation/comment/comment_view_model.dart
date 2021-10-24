import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';

final commentVm = Provider((ref) => CommentViewModel(ref.read));

class CommentViewModel {
  CommentViewModel(this._read);
  final Reader _read;

  Future<void> postComment(Post post, String body) async {}
}
