import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:multas_app/common/splash/splash.dart';
import 'package:multas_app/core/utils/fade_transition/fade_transition.dart';
import 'package:multas_app/core/widgets/navigation_bar.dart';
import 'package:multas_app/features/documents/presentation/documents_page.dart';
import 'package:multas_app/features/home/presentation/home_view.dart';
import 'package:multas_app/features/home/presentation/links_page.dart';
import 'package:multas_app/features/mas/presentation/more_view.dart';
import 'package:multas_app/features/settings/presentation/privacy/privacy_view.dart';
import 'package:multas_app/features/settings/presentation/settings_page.dart';
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
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const Splash(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            BottomNavigationShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                pageBuilder: (context, state) => FadeTransitionPage(
                  key: state.pageKey,
                  child: const HomeView(),
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
                  child: const DocumentsView(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                pageBuilder: (context, state) => FadeTransitionPage(
                  key: state.pageKey,
                  child: const MorePage(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) => const PrivacyView(),
      ),
      GoRoute(
        path: '/consulta',
        builder: (context, state) => const SpacedItemsList(),
      ),
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
