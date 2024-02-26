import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_filter_list.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class CustomExpansionTile extends StatefulWidget {
  final int townCategoryId;
  final int sectionIndex;
  const CustomExpansionTile({
    super.key,
    required this.townCategoryId,
    required this.sectionIndex,
  });

  @override
  State<CustomExpansionTile> createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final title =
        TownSectionsInfo.getByIndex(widget.sectionIndex)?.filterTitle ??
            'Categoría no encontrada';

    return Container(
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
      decoration: const BoxDecoration(
        color: ColorManager.pueblyPrimary1,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Material(
        color: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        child: ExpansionTile(
          title: _TitleText(title),
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
            CustomFilterList(
              townCategoryId: widget.townCategoryId,
              sectionIndex: widget.sectionIndex,
            ),
          ],
        ),
      ),
    );
  }

  RoundedRectangleBorder _expansionTileShape() {
    return RoundedRectangleBorder(
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
