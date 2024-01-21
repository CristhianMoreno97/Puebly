import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/domain/entities/category.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';

class FilterListExpansion extends StatefulWidget {
  final String title;
  final List<Category> filters;
  final int townCategoryId;
  final int sectionId;
  const FilterListExpansion({
    super.key,
    required this.title,
    required this.filters,
    required this.townCategoryId,
    required this.sectionId,
  });

  @override
  State<FilterListExpansion> createState() => _FilterListExpansionState();
}

class _FilterListExpansionState extends State<FilterListExpansion> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: ColorManager.magentaGradient,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: ExpansionTile(
          title: _TitleText(widget.title),
          backgroundColor: Colors.transparent,
          shape: _expansionTileShape(),
          collapsedShape: _expansionTileShape(),
          leading: const Icon(
            Icons.filter_alt,
            color: Colors.white,
          ),
          trailing: Icon(
            _isExpanded
                ? Icons.arrow_drop_up_rounded
                : Icons.arrow_drop_down_rounded,
            color: Colors.white,
          ),
          onExpansionChanged: (isExpanded) {
            setState(() {
              _isExpanded = isExpanded;
            });
          },
          children: [
            _FilterList(
                widget.filters, widget.townCategoryId, widget.sectionId),
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder _expansionTileShape() {
    return RoundedRectangleBorder(
      //side: const BorderSide(color: Colors.white, width: 2),
      borderRadius: BorderRadius.circular(16),
    );
  }
}

class _TitleText extends StatelessWidget {
  final String title;
  const _TitleText(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _FilterList extends ConsumerWidget {
  final List<Category> filters;
  final int townCategoryId;
  final int sectionId;
  const _FilterList(this.filters, this.townCategoryId, this.sectionId);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedData = ref.watch(selectedDataProvider);
    final List<Category> selectedListData =
        selectedData.values.expand((e) => e).toList();
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(0),
        height: 156,
        color: Colors.grey[100],
        child: FilterListWidget(
          listData: filters,
          selectedListData: selectedListData,
          hideSelectedTextCount: true,
          hideHeader: true,
          allButtonText: "Todos",
          resetButtonText: "Ninguno",
          applyButtonText: "Buscar",
          themeData: _filterListThemeData(context),
          onApplyButtonClick: (list) {
            ref.read(selectedDataProvider.notifier).update((state) {
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
                .resetSection(sectionId);
            ref.read(townProvider(townCategoryId).notifier).getPostsByCategory(
                  sectionId,
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
        margin: const EdgeInsets.only(bottom: 16),
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
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              blurRadius: 10,
              offset: const Offset(0, 4), // changes position of shadow
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
        color: isSelected ? ColorManager.magentaTint2 : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorManager.magentaTint1,
        ),
      ),
      child: Text(item.name),
    );
  }
}

final selectedDataProvider =
    StateProvider<Map<int, List<Category>>>((ref) => {});
