import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swing_share/domain/model/post.dart' as domain;
import 'package:swing_share/domain/model/profile.dart';
import 'package:swing_share/presentation/login/login_view_model.dart';

class Post {
  Post({
    this.id,
    this.body,
    this.createdAt,
    this.author,
    this.commentCount = 0,
  });

  final String? id;
  final String? body;
  final DateTime? createdAt;
  final Map<String, dynamic>? author;
  final int commentCount;

  factory Post.fromMap(
    Map<String, dynamic>? data,
    String documentId,
  ) {
    if (data == null) {
      return Post();
    }

    final body = data['body'] as String?;
    DateTime? createdAt;
    if (data['createdAt'] is Timestamp) {
      createdAt = data["createdAt"].toDate();
    }

    final map = data['author'] as Map<String, dynamic>?;
    final commentCount = data['commentCount'] as int?;

    return Post(
      id: documentId,
      body: body,
      createdAt: createdAt,
      author: map,
      commentCount: commentCount ?? 0,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'author': <String, dynamic>{
          'name': '',
        },
        'body': body,
        'createdAt': createdAt,
      };

  domain.Post toEntity() {
    return domain.Post(
      id: id,
      profile: Profile(
        id: author?['ref'].split('/')[1] ?? '',
        name: author?['name'] ?? defaultName,
        thumbnailPath: author?['thumbnailPath'] ?? defaultPhotoUrl,
      ),
      body: body ?? '',
      createdAt: createdAt,
      commentCount: commentCount,
    );
  }
}
