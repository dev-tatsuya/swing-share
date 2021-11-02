import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/post.dart';

part 'home_state.freezed.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<Post> posts,
    @Default(false) bool hasNext,
  }) = _HomeState;
}
