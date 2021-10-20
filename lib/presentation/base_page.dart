import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/presentation/entry/entry_page.dart';
import 'package:swing_share/presentation/home/home_page.dart';
import 'package:swing_share/presentation/login/login_sheet.dart';
import 'package:swing_share/presentation/profile/profile_page.dart';
import 'package:swing_share/router/home_router.dart';
import 'package:swing_share/router/profile_router.dart';

import 'login/login_view_model.dart';

final navigatorKeys = {
  TabItem.home: GlobalKey<NavigatorState>(),
  TabItem.profile: GlobalKey<NavigatorState>(),
};

enum TabItem {
  home,
  entry,
  profile,
}

final tabItem = StateProvider.autoDispose<TabItem>(
  (ref) => TabItem.home,
);

const homePath = '/home';
const entryPath = '/entry';
const profilePath = 'profile';
const detailPath = '/detail';

class BasePage extends ConsumerStatefulWidget {
  const BasePage({Key? key}) : super(key: key);

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends ConsumerState<BasePage> {
  int _selectedIndex = 0;
  TabItem get currentTab => TabItem.values[_selectedIndex];

  final _bodies = [
    const HomePage(),
    const SizedBox(),
    const ProfilePage(),
  ];

  Widget _buildOffstage(TabItem tabItem, TabItem currentTab) {
    return Offstage(
      offstage: currentTab != tabItem,
      child: Navigator(
        key: navigatorKeys[tabItem],
        onGenerateRoute: (settings) => _routeMap(settings)[tabItem],
      ),
    );
  }

  Map<TabItem, Route<dynamic>> _routeMap(RouteSettings settings) => {
        TabItem.home: onGenerateHomeRoute(settings),
        TabItem.profile: onGenerateProfileRoute(settings),
      };

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

    if (index == _selectedIndex) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _buildOffstages(bool isLogin) {
    return [
      _buildOffstage(TabItem.home, currentTab),
      if (isLogin) _buildOffstage(TabItem.profile, currentTab),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: ref.watch(loginVm).authStateChanges,
        builder: (context, snapshot) {
          log('authState: ${snapshot.data}');
          final isLogin = snapshot.data != null;
          return Scaffold(
            body: Stack(children: _buildOffstages(isLogin)),
            // body: _bodies.elementAt(isLogin ? _selectedIndex : 0),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: isLogin ? _selectedIndex : 0,
              onTap: (index) => _onItemTapped(index, isLogin: isLogin),
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled),
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
