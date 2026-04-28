import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/auth/pages/auth_page.dart';
import '../../features/dashboard/pages/dashboard_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/friends/pages/friends_page.dart';
import '../../features/groups/pages/groups_page.dart';
import '../../features/expense/pages/add_expense_page.dart';
import '../../features/expense/pages/who_paid_page.dart';
import '../../features/dashboard/widgets/scaffold_with_navbar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      builder: (context, state) => const AuthPage(),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/groups',
              builder: (context, state) => const GroupsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/friends',
              builder: (context, state) => const FriendsPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add-expense',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) => const AddExpensePage(),
    ),
    GoRoute(
      path: '/who-paid',
      parentNavigatorKey: _rootNavigatorKey,
      builder: (context, state) {
        final currencyCode = state.extra as String? ?? 'USD';
        return WhoPaidPage(currencyCode: currencyCode);
      },
    ),
  ],
);
