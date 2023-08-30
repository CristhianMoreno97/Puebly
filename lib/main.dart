import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/app_theme.dart';

import 'config/constants/enviroment_constants.dart';
import 'config/router/app_router_provider.dart';

void main() async {
  await EnviromentConstants.initEnviroment();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(appRouterProvider);
    return MaterialApp.router(
      routerConfig: appRouter,
      theme: const AppTheme().getTheme(),
    );
  }
}
