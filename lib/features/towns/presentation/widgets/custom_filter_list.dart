import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/domain/entities/category.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';

class CustomFilterList extends ConsumerWidget {
  final List<Category> filters;
  final int townCategoryId;
  final int sectionIndex;
  const CustomFilterList({
    super.key,
    required this.filters,
    required this.townCategoryId,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedData = ref.watch(selectedFiltersProvider);
    final List<Category> selectedListData =
        selectedData.values.expand((e) => e).toList();
    final bool isLoading =
        ref.watch(townProvider(townCategoryId)).isChildCategoriesLoading;
    final height = MediaQuery.of(context).size.height;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(0),
        height: height * 0.4,
        color: Colors.white,
        child: Stack(
          children: [
            FilterListWidget(
              listData: filters,
              selectedListData: selectedListData,
              hideSelectedTextCount: true,
              hideHeader: true,
              allButtonText: "Todos",
              resetButtonText: "Limpiar",
              applyButtonText: "Buscar",
              themeData: _filterListThemeData(context),
              onApplyButtonClick: (list) {
                ref.read(selectedFiltersProvider.notifier).update((state) {
                  state.clear();
                  if (list != null) {
                    for (final element in list) {
                      state[element.id] = [element];
                    }
                  }
                  return state;
                });
                ref
                    .read(townProvider(townCategoryId).notifier)
                    .resetSection(sectionIndex);
                ref.read(townProvider(townCategoryId).notifier).getSectionPosts(
                      sectionIndex,
                      childCategories: list?.map((e) => e.id).toList(),
                    );
              },
              validateSelectedItem: (list, item) {
                if (list == null) return false;
                return list.contains(item);
              },
              choiceChipLabel: (item) {
                return item!.name;
              },
              onItemSearch: (item, query) {
                return item.name.toLowerCase().contains(query.toLowerCase());
              },
              choiceChipBuilder: (context, item, isSelected) => _ChoiceChip(
                item: item,
                isSelected: isSelected ?? false,
              ),
            ),
            if (isLoading) const _LoadingProgress(),
          ],
        ),
      ),
    );
  }

  _filterListThemeData(BuildContext context) {
    return FilterListThemeData.raw(
      borderRadius: 0,
      wrapAlignment: WrapAlignment.start,
      wrapCrossAxisAlignment: WrapCrossAlignment.start,
      wrapSpacing: 0,
      backgroundColor: Colors.transparent,
      headerTheme: const HeaderThemeData(),
      choiceChipTheme: const ChoiceChipThemeData(),
      controlBarButtonTheme: ControlButtonBarThemeData.raw(
        height: 40,
        padding: const EdgeInsets.all(0),
        //margin: const EdgeInsets.only(bottom: 16),
        controlButtonTheme: ControlButtonThemeData(
          borderRadius: 8,
          textStyle: Theme.of(context).textTheme.bodyMedium,
          primaryButtonBackgroundColor: ColorManager.magenta,
        ),
        controlContainerDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black12.withOpacity(0.1),
              spreadRadius: -1,
              blurRadius: 4,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChoiceChip extends StatelessWidget {
  final Category item;
  final bool isSelected;
  const _ChoiceChip({
    required this.item,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.magentaTint2 : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        item.name,
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
              color: isSelected ? ColorManager.magentaShade2 : Colors.grey[800],
            ),
      ),
    );
  }
}

final selectedFiltersProvider =
    StateProvider<Map<int, List<Category>>>((ref) => {});

class _LoadingProgress extends StatelessWidget {
  const _LoadingProgress();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LinearProgressIndicator(
          color: ColorManager.colorSeed,
          backgroundColor: Colors.white,
        ),
        Expanded(
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
        ),
      ],
    );
  }
}
