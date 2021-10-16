import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/service/auth_service.dart';
import 'package:swing_share/infra/service/auth_service_impl.dart';

final loginVm = Provider((ref) => LoginViewModel(ref.read));

class LoginViewModel {
  LoginViewModel(this._read);
  final Reader _read;

  AuthService get _auth => _read(authService);

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<User?> loginAnonymously() async {
    try {
      EasyLoading.show();
      await _auth.loginAnonymously();
      EasyLoading.dismiss();
    } on Exception catch (ex) {
      EasyLoading.dismiss();
      log(ex.toString());
    }
  }

  Future<User?> loginWithApple() async {
    try {
      EasyLoading.show();
      await _auth.loginWithApple();
      EasyLoading.dismiss();
    } on Exception catch (ex) {
      EasyLoading.dismiss();
      log(ex.toString());
    }
  }

  Future<User?> loginWithGoogle() async {
    try {
      EasyLoading.show();
      await _auth.loginWithGoogle();
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
}
