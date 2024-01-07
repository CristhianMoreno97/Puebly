import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/features/home/presentation/screens/auxiliary_screen.dart';
import 'package:puebly/features/home/presentation/screens/main_screen.dart';
import 'package:puebly/features/towns/presentation/screens/town_sections_screen.dart';
import 'package:puebly/features/towns/presentation/screens/towns_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/towns',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/auxiliary-screen',
        builder: (context, state) => const AuxiliaryScreen(),
      ),
      GoRoute(
        path: '/towns',
        builder: (context, state) => const TownsScreen(),
      ),
      GoRoute(
        path: '/town/:townCategoryId',
        builder: (context, state) =>
            TownSectionsScreen(townCategoryId: state.pathParameters['townCategoryId'] ?? 'no-id'),
      ),
    ],
  );
});
