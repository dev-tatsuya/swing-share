import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/service/auth_service.dart';
import 'package:swing_share/infra/model/profile.dart';
import 'package:swing_share/infra/repository/repository_impl.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';

final loginVm = Provider((ref) => LoginViewModel(ref.read));

const defaultName = '匿名';
const defaultPhotoUrl =
    'https://knsoza1.com/wp-content/uploads/2020/07/70b3dd52350bf605f1bb4078ef79c9b9.png';

class LoginViewModel {
  LoginViewModel(this._read);
  final Reader _read;

  AuthService get _auth => _read(authService);

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User?> loginAnonymously() async {
    try {
      EasyLoading.show();
      final user = await _auth.loginAnonymously();
      await _setUser(user);
      EasyLoading.dismiss();
    } on Exception catch (ex) {
      EasyLoading.dismiss();
      log(ex.toString());
    }
  }

  Future<User?> loginWithApple() async {
    try {
      EasyLoading.show();
      final user = await _auth.loginWithApple();
      await _setUser(user);
      EasyLoading.dismiss();
    } on Exception catch (ex) {
      EasyLoading.dismiss();
      log(ex.toString());
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      EasyLoading.show();
      final user = await _auth.loginWithGoogle();
      await _setUser(user);
      EasyLoading.dismiss();
    } on Exception catch (ex) {
      EasyLoading.dismiss();
      log(ex.toString());
    }
  }

  Future<void> logout() async {
    try {
      EasyLoading.show();
      await _auth.logout();
      EasyLoading.dismiss();
    } on Exception catch (ex) {
      EasyLoading.dismiss();
      log(ex.toString());
    }
  }

  Future<void> _setUser(User? user) async {
    await _read(repo).setProfile(
      Profile(
        name: user?.displayName ?? defaultName,
        thumbnailPath: user?.photoURL ?? defaultPhotoUrl,
      ),
    );
  }
}
