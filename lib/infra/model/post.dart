import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    this.id,
    this.authorRef,
    this.body,
    this.createdAt,
    this.author,
  });

  final String? id;
  final String? authorRef;
  final String? body;
  final DateTime? createdAt;
  final Map<String, dynamic>? author;

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

    return Post(
      id: documentId,
      // authorRef: authorRef,
      body: body,
      createdAt: createdAt,
      author: map,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'author': <String, dynamic>{
          'name': '',
        },
        'authorRef': authorRef,
        'body': body,
        'createdAt': createdAt,
      };
}
