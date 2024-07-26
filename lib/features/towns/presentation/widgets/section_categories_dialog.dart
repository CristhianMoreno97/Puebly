import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/shared/presentation/widgets/image_viewer_widget.dart';
import 'package:puebly/features/shared/presentation/widgets/linear_progress_widget.dart';
import 'package:puebly/features/towns/domain/entities/category.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_secundary_button.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class SectionCategoriesDialog extends StatelessWidget {
  final int townId; // same townCategoryId
  final int sectionIndex;

  const SectionCategoriesDialog({
    super.key,
    required this.townId,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final title = TownSectionsInfo.getByIndex(sectionIndex)?.filterTitle ??
        'Seleccione una categoría';
    onTap() {
      showDialog(
        context: context,
        builder: (_) => _CategoriesSimpleDialog(
          townId: townId,
          sectionIndex: sectionIndex,
        ),
      );
    }

    return CustomSecundaryButton(
      text: title,
      onTap: onTap,
    );
  }
}

class _CategoriesSimpleDialog extends ConsumerWidget {
  final int townId;
  final int sectionIndex;

  const _CategoriesSimpleDialog({
    required this.townId,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Category> categories = ref
        .watch(townProvider(townId))
        .townSections[sectionIndex]
        .childCategories;
    final int? categorySelected =
        ref.watch(sectionCategorySelectedProvider)[sectionIndex];
    final isLoadingSection =
        ref.watch(townProvider(townId)).townSections[sectionIndex].isLoading;
    final isLoadingCategories =
        ref.watch(townProvider(townId)).isChildCategoriesLoading;

    void onPressed(Category category) {
      if (isLoadingSection) return;

      final int? selectedFilter =
          categorySelected == category.id ? null : category.id;

      ref
          .read(sectionCategorySelectedProvider.notifier)
          .update((state) => {...state, sectionIndex: selectedFilter});
      ref.read(townProvider(townId).notifier).resetSection(sectionIndex);
      ref.read(townProvider(townId).notifier).getSectionPosts(
            sectionIndex,
            childCategories: selectedFilter != null ? [selectedFilter] : null,
          );

      if (context.mounted) {
        Navigator.pop(context);
      }
    }

    return SimpleDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      title: Text(
        'Seleccione una categoría',
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: ColorManager.pueblySecundary1,
            ),
      ),
      titlePadding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      children: [
        isLoadingSection ? const LinearProgressWidget() : const SizedBox(),
        isLoadingCategories
            ? const SizedBox(height: 540, child: ImageViewerWidget(''))
            : const SizedBox(),
        ...categories.map((category) {
          final isSelected = categorySelected == category.id;
          return _CategoryOption(
            category,
            isSelected: isSelected,
            onPressed: onPressed,
          );
        }),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _CategoryOption extends StatelessWidget {
  final Category category;
  final bool isSelected;
  final void Function(Category category) onPressed;

  const _CategoryOption(
    this.category, {
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: isSelected ? ColorManager.orangePeel : Colors.transparent,
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          category.name,
          style: isSelected
              ? Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  )
              : Theme.of(context).textTheme.bodyMedium,
        ),
      ),
      onPressed: () => onPressed(category),
    );
  }
}

final sectionCategorySelectedProvider =
    StateProvider<Map<int, int?>>((ref) => {});
