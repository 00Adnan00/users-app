import 'package:go_router/go_router.dart';
import 'package:users_app/src/features/users/presentation/detailed_user_screen.dart';
import 'package:users_app/src/features/users/presentation/users_screen.dart';

enum AppRoute { users, detailedUser }

final appRouter = GoRouter(
  initialLocation: '/${AppRoute.users.name}',
  routes: [
    GoRoute(
      path: '/${AppRoute.users.name}',
      name: AppRoute.users.name,
      builder: (context, state) => const UsersScreen(),
      routes: [
        GoRoute(
          path: 'users/:id',
          name: AppRoute.detailedUser.name,
          builder: (context, state) => DetailedUserScreen(
            id: int.parse(state.pathParameters['id']!),
          ),
        ),
      ],
    ),
  ],
);
