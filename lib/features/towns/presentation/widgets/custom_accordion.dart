import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_filter_list.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class CustomAccordion extends StatelessWidget {
  final int townCategoryId;
  final int sectionIndex;

  const CustomAccordion({
    super.key,
    required this.townCategoryId,
    required this.sectionIndex,
  });

  @override
  Widget build(BuildContext context) {
    final title = TownSectionsInfo.getByIndex(sectionIndex)?.filterTitle ??
        'Categoría no encontrada';

    return Accordion(
      openAndCloseAnimation: true,
      headerPadding: const EdgeInsets.all(12),
      headerBackgroundColor: ColorManager.pueblyPrimary1,
      contentBackgroundColor: Colors.white,
      contentBorderRadius: 16,
      contentBorderColor: Colors.transparent,
      disableScrolling: true,
      scaleWhenAnimating: false,
      paddingBetweenClosedSections: 0,
      paddingBetweenOpenSections: 0,
      paddingListBottom: 0,
      paddingListTop: 16,
      paddingListHorizontal: 16,
      contentHorizontalPadding: 0,
      contentVerticalPadding: 0,
      children: [
        AccordionSection(
          isOpen: false,
          header: _TitleText(title),
          content: CustomFilterList(
            townCategoryId: townCategoryId,
            sectionIndex: sectionIndex,
          ),
        ),
      ],
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
