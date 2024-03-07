import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/domain/entities/category.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';

class CustomFilterWrap extends ConsumerWidget {
  final int townCategoryId;
  final int sectionIndex;

  const CustomFilterWrap({
    super.key,
    required this.townCategoryId,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref
        .watch(townProvider(townCategoryId))
        .townSections[sectionIndex]
        .childCategories;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: Wrap(
            direction: Axis.horizontal,
            crossAxisAlignment: WrapCrossAlignment.end,
            alignment: WrapAlignment.start,
            spacing: 8,
            runSpacing: 4,
            children: categories
                .map((category) => _ChoiceChip(
                      category: category,
                      sectionIndex: sectionIndex,
                      townCategoryId: townCategoryId,
                    ))
                .toList(),
          ),
        ),
      ],
    );
  }
}

class _ChoiceChip extends ConsumerWidget {
  final Category category;
  final int townCategoryId;
  final int sectionIndex;
  const _ChoiceChip({
    required this.category,
    required this.townCategoryId,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategoryIds = ref.watch(selectedFiltersProvider);
    final isSelected = selectedCategoryIds.contains(category.id);
    return ChoiceChip(
      label: Text(category.name),
      selected: selectedCategoryIds.contains(category.id),
      padding: const EdgeInsets.all(0),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      visualDensity: VisualDensity.compact,
      showCheckmark: false,
      labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
            color: isSelected
                ? ColorManager.brightYellowShade2
                : ColorManager.blueOuterSpace,
          ),
      color: isSelected
          ? MaterialStateProperty.all<Color>(ColorManager.brightYellowTint2)
          : MaterialStateProperty.all<Color>(Colors.white),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide.none,
      onSelected: (value) async {
        if (ref
            .read(townProvider(townCategoryId))
            .townSections[sectionIndex]
            .isLoading) {
          return;
        }
        final currentSet = Set<int>.from(ref.read(selectedFiltersProvider));
        if (value) {
          currentSet.add(category.id);
        } else {
          currentSet.remove(category.id);
        }
        ref.read(selectedFiltersProvider.notifier).state = currentSet;
        ref
            .read(townProvider(townCategoryId).notifier)
            .resetSection(sectionIndex);
        await ref.read(townProvider(townCategoryId).notifier).getSectionPosts(
              sectionIndex,
              childCategories: currentSet.toList(),
            );
      },
    );
  }
}

final selectedFiltersProvider = StateProvider<Set<int>>((ref) => {});

