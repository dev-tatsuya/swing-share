import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/comment.dart';

part 'detail_state.freezed.dart';

@freezed
abstract class DetailState with _$DetailState {
  const factory DetailState({
    @Default([]) List<Comment> comments,
  }) = _DetailState;
}
