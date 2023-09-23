import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goToSection(int sectionIndex) {
      ref.read(showHomeScreenProvider.notifier).state = false;
      ref.read(pageControllerProvider.notifier).update((state) {
        state.animateToPage(sectionIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        return state;
      });
    }

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () => goToSection(0),
                child: const Text('Comercio'),
              ),
              FilledButton(
                onPressed: () => goToSection(1),
                child: const Text('Turismo'),
              ),
              FilledButton(
                onPressed: () => goToSection(2),
                child: const Text('Plaza'),
              ),
              FilledButton(
                onPressed: () => goToSection(3),
                child: const Text('Empleo'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
