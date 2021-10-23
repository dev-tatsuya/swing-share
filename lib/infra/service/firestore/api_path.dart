class APIPath {
  static String user(String uid) => 'users/$uid';
  static String posts(String uid) => 'users/$uid/posts';
  static String post(String uid, String docId) => 'users/$uid/posts/$docId';
  static String comments(String uid, String postId) =>
      'users/$uid/posts/$postId/comments';
  static String comment(String uid, String postId, String docId) =>
      'users/$uid/posts/$postId/comments/$docId';
}
