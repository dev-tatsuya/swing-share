class APIPath {
  static String user(String uid) => 'users/$uid';
  static String posts(String uid) => 'users/$uid/posts';
  static String post(String uid, String docId) => 'users/$uid/posts/$docId';
}
