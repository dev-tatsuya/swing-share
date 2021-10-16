import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/presentation/entry/entry_page.dart';
import 'package:swing_share/presentation/home/home_page.dart';
import 'package:swing_share/presentation/login/login_sheet.dart';
import 'package:swing_share/presentation/profile/profile_page.dart';

import 'login/login_view_model.dart';

class BasePage extends ConsumerStatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends ConsumerState<BasePage> {
  int _selectedIndex = 0;
  final _bodies = [
    HomePage(),
    const SizedBox(),
    ProfilePage(),
  ];

  void _onItemTapped(int index, {required bool isLogin}) {
    if ((index == 1 || index == 2) && !isLogin) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        builder: (_) => const LoginSheet(),
      );
      return;
    }

    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (_) => const EntryPage(),
        ),
      );
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: ref.watch(loginVm).authStateChanges,
        builder: (context, snapshot) {
          log('authState: ${snapshot.data}');
          final isLogin = snapshot.data != null;
          return Scaffold(
            body: _bodies.elementAt(isLogin ? _selectedIndex : 0),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: isLogin ? _selectedIndex : 0,
              onTap: (index) => _onItemTapped(index, isLogin: isLogin),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home_filled,
                  ),
                  label: '',
                  tooltip: 'ホーム',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_circle_outline),
                  label: '',
                  tooltip: '追加',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: '',
                  tooltip: 'プロフィール',
                ),
              ],
            ),
          );
        });
  }
}
