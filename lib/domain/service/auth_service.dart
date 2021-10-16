import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthService {
  User? get currentUser;
  Stream<User?> authStateChanges();
  Future<User?> loginAnonymously();
  Future<User?> loginWithApple();
  Future<User?> loginWithGoogle();
  Future<void> logout();
}
