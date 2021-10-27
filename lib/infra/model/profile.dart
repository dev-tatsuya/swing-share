import 'package:swing_share/domain/model/profile.dart' as domain;
import 'package:swing_share/presentation/login/login_view_model.dart';

class Profile {
  Profile({
    this.id,
    this.name,
    this.thumbnailPath,
  });

  factory Profile.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      return Profile();
    }
    final name = data['name'] as String?;
    final thumbnailPath = data['thumbnailPath'] as String?;
    return Profile(
      id: documentId,
      name: name,
      thumbnailPath: thumbnailPath,
    );
  }

  final String? id;
  final String? name;
  final String? thumbnailPath;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'thumbnailPath': thumbnailPath,
      };

  domain.Profile toEntity() {
    return domain.Profile(
      id: id,
      name: name ?? defaultName,
      thumbnailPath: thumbnailPath ?? defaultPhotoUrl,
    );
  }
}
