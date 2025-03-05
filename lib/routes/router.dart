import 'package:go_router/go_router.dart';
import 'package:myfood/screens.dart';

class NoTransitionPage extends CustomTransitionPage {
  NoTransitionPage({required super.child})
    : super(
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
      );
}

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder:
          (context, state) => NoTransitionPage(child: const HomeScreen()),
    ),
    GoRoute(
      path: '/search',
      pageBuilder:
          (context, state) => NoTransitionPage(child: const SearchScreen()),
    ),
    GoRoute(
      path: '/orders',
      pageBuilder:
          (context, state) => NoTransitionPage(child: const OrdersScreen()),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder:
          (context, state) => NoTransitionPage(child: const ProfileScreen()),
    ),
  ],
);
