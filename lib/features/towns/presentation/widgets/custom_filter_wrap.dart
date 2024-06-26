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

    final isLoadingSection = _isLoadingSection(ref);
    final isLoadingCategories = _isLoadingCategories(ref);

    return PopScope(
      onPopInvoked: (didPop) async {
        if (didPop) return;
        await _resetAndFetchSection(ref, {});
      },
      child: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: _buildChoiceChipWrap(categories, sectionIndex, townCategoryId),
        ),
        Container(color: Colors.transparent, height: 8),
        if (isLoadingCategories) const _ImageLoader(),
        if (isLoadingSection) const _LinearLoader(),
      ]),
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

  bool _isLoadingSection(WidgetRef ref) {
    return ref
        .read(townProvider(townCategoryId))
        .townSections[sectionIndex]
        .isLoading;
  }

  bool _isLoadingCategories(WidgetRef ref) {
    return ref.watch(townProvider(townCategoryId)).isChildCategoriesLoading;
  }

  Future<void> _resetAndFetchSection(WidgetRef ref, Set<int> currentSet) async {
    final selectedFilters = ref.read(selectedFiltersProvider);
    final isLoading = ref
        .read(townProvider(townCategoryId))
        .townSections[sectionIndex]
        .isLoading;
    if (selectedFilters.isEmpty || isLoading) return;

    ref.read(townProvider(townCategoryId).notifier).resetSection(sectionIndex);
    ref.read(selectedFiltersProvider.notifier).state[sectionIndex] = currentSet;
    await ref.read(townProvider(townCategoryId).notifier).getSectionPosts(
          sectionIndex,
          childCategories: currentSet.toList(),
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
          ? WidgetStateProperty.all<Color>(ColorManager.brightYellowTint2)
          : WidgetStateProperty.all<Color>(Colors.white),
    );
  }

  TextStyle _chipLabelStyle(BuildContext context, bool isSelected) {
    return Theme.of(context).textTheme.bodyMedium!.copyWith(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          color: isSelected
              ? ColorManager.brightYellowShade2
              : ColorManager.blueOuterSpace,
        );
  }

  bool _isSelected(WidgetRef ref, int categoryId) {
    final selectedCategoryIds = ref.watch(selectedFiltersProvider)[sectionIndex] ?? {};
    return selectedCategoryIds.contains(categoryId);
  }

  void _handleChipSelected(WidgetRef ref, bool value) async {
    if (!_isLoadingSection(ref)) {
      final currentSet = <int>{};

      value ? currentSet.add(category.id) : currentSet.remove(category.id);
      
      ref.read(selectedFiltersProvider.notifier).state[sectionIndex] = currentSet;

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

final selectedFiltersProvider = StateProvider<Map<int, Set<int>>>((ref) => {});

class _LinearLoader extends StatelessWidget {
  const _LinearLoader();

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(
        color: ColorManager.colorSeed, backgroundColor: Colors.white);
  }
}

class _ImageLoader extends StatelessWidget {
  const _ImageLoader();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Container(
        color: Colors.white,
        child: Align(
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/puebly-loader.gif',
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
