import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swing_share/domain/model/post.dart';
import 'package:swing_share/presentation/base_page.dart';
import 'package:swing_share/presentation/detail/detail_page.dart';
import 'package:swing_share/presentation/home/home_page.dart';

final homeRouterProvider = Provider((ref) => HomeRouter());

class HomeRouter {
  final GlobalKey<NavigatorState> navigatorKey = navigatorKeys[TabItem.home]!;
  BuildContext get context => navigatorKey.currentContext!;

  void pop<T extends Object>([T? result]) {
    navigatorKey.currentState!.pop(result);
  }

  Future<dynamic> navigateTo(String routeName, {Object? args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }
}

final Map<String, Widget> _routeWidgetsMap = {
  homePath: const HomePage(),
};

Route<dynamic> onGenerateHomeRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePath:
      return MaterialPageRoute<void>(
        builder: (context) => _routeWidgetsMap[homePath]!,
      );
    case detailPath:
      final args = settings.arguments! as Post;
      return MaterialPageRoute<void>(
        builder: (context) => DetailPage(args),
      );
  }
  return MaterialPageRoute<Widget>(
    builder: (context) => const HomePage(),
  );
}
