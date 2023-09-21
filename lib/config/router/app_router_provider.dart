import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/features/home/presentation/screens/auxiliary_screen.dart';
import 'package:puebly/features/home/presentation/screens/main_screen.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/auxiliary-screen',
        builder: (context, state) =>
            const AuxiliaryScreen(),
      ),
    ],
  );
});
