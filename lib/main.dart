import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/app_theme.dart';
import 'package:puebly/features/home/presentation/providers/is_dark_mode_provider.dart';

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
    final isDarkMode = ref.watch(isDarkModeProvider);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)),
          child: child!,
        );
      },
      routerConfig: appRouter,
      theme: AppTheme(isDarkMode: isDarkMode).getTheme(),
    );
  }
}
