import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swing_share/domain/model/comment.dart' as domain;
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';

class Comment {
  Comment({
    this.id,
    this.body,
    this.createdAt,
    this.author,
  });

  final String? id;
  final String? body;
  final DateTime? createdAt;
  final Map<String, dynamic>? author;

  factory Comment.fromMap(
    Map<String, dynamic>? data,
    String documentId,
  ) {
    if (data == null) {
      return Comment();
    }

    final body = data['body'] as String?;
    DateTime? createdAt;
    if (data['createdAt'] is Timestamp) {
      createdAt = data["createdAt"].toDate();
    }

    final map = data['author'] as Map<String, dynamic>?;

    return Comment(
      id: documentId,
      body: body,
      createdAt: createdAt,
      author: map,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'author': <String, dynamic>{
          'name': '',
        },
        'body': body,
        'createdAt': createdAt,
      };

  domain.Comment toEntity() {
    return domain.Comment(
      id: id,
      profile: Profile(
        id: author?['ref'].split('/')[1] ?? '',
        name: author?['name'] ?? defaultName,
        thumbnailPath: author?['thumbnailPath'] ?? defaultPhotoUrl,
      ),
      body: body ?? '',
      createdAt: createdAt,
    );
  }
}
