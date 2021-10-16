import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  Post({
    this.id,
    this.authorRef,
    this.body,
    this.createdAt,
  });

  final String? id;
  final String? authorRef;
  final String? body;
  final DateTime? createdAt;

  factory Post.fromMap(
    Map<String, dynamic>? data,
    String documentId,
  ) {
    if (data == null) {
      return Post();
    }

    final authorRef = data['authorRef'] as String?;
    final body = data['body'] as String?;
    DateTime? createdAt;
    if (data['createdAt'] is Timestamp) {
      createdAt = data["createdAt"].toDate();
    }
    return Post(
      id: documentId,
      authorRef: authorRef,
      body: body,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        'authorRef': authorRef,
        'body': body,
        'createdAt': createdAt,
      };
}
