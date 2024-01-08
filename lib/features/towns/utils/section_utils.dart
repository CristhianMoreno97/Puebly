import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';

class SectionUtils {
  static Future<void> navigateTo(int index, WidgetRef ref, BuildContext context) async {
    ref.read(sectionsPageControllerProvider.notifier).update((state) {
      state.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      return state;
    });
    final width = MediaQuery.of(context).size.width;
    final offset = index < 3 ? 0.0 : index * 36.0;
    ref.read(sectionsScrollControllerProvider.notifier).update((state) {
      state.animateTo(
        width < 572.0 ? offset : 0.0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
      );
      return state;
    });
    ref.read(showTownSectionsViewProvider.notifier).state = false;
  }
}
