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
    final List<Category> categories = ref
        .watch(townProvider(townCategoryId))
        .townSections[sectionIndex]
        .childCategories;

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          child: _buildChoiceChipWrap(categories, sectionIndex, townCategoryId),
        ),
      ],
    );
  }

  Widget _buildChoiceChipWrap(
      List<Category> categories, int sectionIndex, int townCategoryId) {
    return Wrap(
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
    final isSelected = _isSelected(ref, category.id);
    return ChoiceChip(
      label: Text(category.name),
      selected: isSelected,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      visualDensity: VisualDensity.compact,
      showCheckmark: false,
      labelStyle: _chipLabelStyle(context, isSelected),
      onSelected: (value) => _handleChipSelected(ref, value),
      side: BorderSide.none,
      color: isSelected
          ? MaterialStateProperty.all<Color>(ColorManager.brightYellowTint2)
          : MaterialStateProperty.all<Color>(Colors.white),
    );
  }

  TextStyle _chipLabelStyle(BuildContext context, bool isSelected) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          color: isSelected
              ? ColorManager.brightYellowShade2
              : ColorManager.blueOuterSpace,
        );
  }

  bool _isSelected(WidgetRef ref, int categoryId) {
    final selectedCategoryIds = ref.watch(selectedFiltersProvider);
    return selectedCategoryIds.contains(categoryId);
  }

  void _handleChipSelected(WidgetRef ref, bool value) async {
    if (!_isLoadingSection(ref)) {
      final currentSet = Set<int>.from(ref.read(selectedFiltersProvider));
      value ? currentSet.add(category.id) : currentSet.remove(category.id);
      ref.read(selectedFiltersProvider.notifier).state = currentSet;

      await _resetAndFetchSection(ref, currentSet);
    }
  }

  bool _isLoadingSection(WidgetRef ref) {
    return ref
        .read(townProvider(townCategoryId))
        .townSections[sectionIndex]
        .isLoading;
  }

  Future<void> _resetAndFetchSection(WidgetRef ref, Set<int> currentSet) async {
    ref.read(townProvider(townCategoryId).notifier).resetSection(sectionIndex);
    await ref.read(townProvider(townCategoryId).notifier).getSectionPosts(
          sectionIndex,
          childCategories: currentSet.toList(),
        );
  }
}

final selectedFiltersProvider = StateProvider<Set<int>>((ref) => {});

