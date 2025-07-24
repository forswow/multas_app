import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multas_app/common/splash/splash.dart';
import 'package:multas_app/core/utils/fade_transition/fade_transition.dart';
import 'package:multas_app/core/widgets/navigation_bar.dart';
import 'package:multas_app/features/doc/presentation/doc_page.dart';
import 'package:multas_app/features/home/presentation/home_page.dart';
import 'package:multas_app/features/mas/presentation/mas_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  log('🚀 router provider called');

  final shellNavigatorKey = GlobalKey<NavigatorState>();

  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    observers: [MyNavigatorObserver()],
    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const Splash()),
      StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) =>
              BottomNavigationView(navigationShell: navigationShell),
          branches: [
            StatefulShellBranch(
              navigatorKey: shellNavigatorKey,
              routes: [
                GoRoute(
                  path: '/',
                  pageBuilder: (context, state) => FadeTransitionPage(
                    key: state.pageKey,
                    child: const HomePage(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/documents',
                  pageBuilder: (context, state) => FadeTransitionPage(
                    key: state.pageKey,
                    child: const DocumentsPage(),
                  ),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                    path: '/mas',
                    pageBuilder: (context, state) => FadeTransitionPage(
                          key: state.pageKey,
                          child: const AdemasPageApp(),
                        ),
                    routes: []),
              ],
            ),
          ])
    ],
  );
  ref.onDispose(() {
    log('🚀 router disposed');
    router.dispose();
  });

  return router;
}

class MyNavigatorObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    log('📍 Pushed route: ${route.settings.name}');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    log('📍 Popped route: ${route.settings.name}');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    log('📍 Removed route: ${route.settings.name}');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    log('📍 Replaced route: ${newRoute?.settings.name}');
  }
}
