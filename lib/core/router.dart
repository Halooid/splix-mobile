import 'package:go_router/go_router.dart';
import '../../features/splash/pages/splash_page.dart';
import '../../features/auth/pages/auth_page.dart';
import '../../features/dashboard/pages/dashboard_page.dart';
import '../../features/profile/pages/profile_page.dart';
import '../../features/friends/pages/friends_page.dart';
import '../../features/groups/pages/groups_page.dart';
import '../../features/expense/pages/add_expense_page.dart';

final router = GoRouter(
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
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/friends',
      builder: (context, state) => const FriendsPage(),
    ),
    GoRoute(
      path: '/groups',
      builder: (context, state) => const GroupsPage(),
    ),
    GoRoute(
      path: '/add-expense',
      builder: (context, state) => const AddExpensePage(),
    ),
  ],
);
