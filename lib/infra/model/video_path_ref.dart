import 'package:hive/hive.dart';

part 'video_path_ref.g.dart';

@HiveType(typeId: 0)
class VideoPathRef extends HiveObject {
  VideoPathRef(this.ref, this.path);

  @HiveField(0)
  String ref;

  @HiveField(1)
  String path;

  @override
  String toString() {
    return '{ref: $ref, path: $path}';
  }
}
