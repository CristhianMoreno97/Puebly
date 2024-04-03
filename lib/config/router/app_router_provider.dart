import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/features/analytics/services/analytics_service.dart';
import 'package:puebly/features/home/presentation/screens/auxiliary_screen.dart';
import 'package:puebly/features/home/presentation/screens/main_screen.dart';
import 'package:puebly/features/towns/presentation/screens/post_screen.dart';
import 'package:puebly/features/towns/presentation/screens/town_sections_screen.dart';
import 'package:puebly/features/towns/presentation/screens/towns_screen.dart';
import 'package:puebly/features/towns/presentation/screens/webview_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    observers: [
      FirebaseAnalyticsObserver(analytics: AnalyticsService.getInstance()),
    ],
    initialLocation: '/app/towns',
    routes: [
      GoRoute(
        path: '/app',
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: '/app/auxiliary-screen',
        builder: (context, state) => const AuxiliaryScreen(),
      ),
      GoRoute(
        path: '/app/towns',
        builder: (context, state) => const TownsScreen(),
      ),
      GoRoute(
        path: '/app/town/:townCategoryId',
        builder: (context, state) => TownSectionsScreen(
            townId: state.pathParameters['townCategoryId'] ?? 'no-id'),
      ),
      GoRoute(
        path: '/app/post/:postId',
        builder: (context, state) => PostScreen(
            postId: state.pathParameters['postId'] ?? 'no-id'),
      ),
      GoRoute(
        path: '/app/webview',
        builder: (context, state) => const WebViewScreen(),
      ),
    ],
  );
});
