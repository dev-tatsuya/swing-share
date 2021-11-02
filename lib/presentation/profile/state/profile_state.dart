import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/domain/model/profile.dart';

part 'profile_state.freezed.dart';

@freezed
abstract class ProfileState with _$ProfileState {
  const factory ProfileState({
    Profile? profile,
    @Default([]) List<Post> posts,
    @Default(false) bool hasNext,
  }) = _ProfileState;
}
