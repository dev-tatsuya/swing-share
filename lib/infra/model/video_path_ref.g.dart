// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_path_ref.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VideoPathRefAdapter extends TypeAdapter<VideoPathRef> {
  @override
  final int typeId = 0;

  @override
  VideoPathRef read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VideoPathRef(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VideoPathRef obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ref)
      ..writeByte(1)
      ..write(obj.path);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VideoPathRefAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
