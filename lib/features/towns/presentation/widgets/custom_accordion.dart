import 'package:accordion/accordion.dart';
import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_filter_wrap.dart';
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
      headerBackgroundColor: Colors.white,
      headerBorderRadius: 16,
      headerBorderWidth: 1,
      headerBorderColor: ColorManager.blueOuterSpaceTint6,
      contentBackgroundColor: Colors.transparent,
      contentBorderRadius: 16,
      contentBorderWidth: 1,
      contentBorderColor: ColorManager.greyCultured,
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
          rightIcon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: ColorManager.blueOuterSpace,
          ),
          leftIcon: const Icon(
            Icons.filter_alt,
            color: ColorManager.blueOuterSpace,
          ),
          content: CustomFilterWrap(
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
        color: ColorManager.blueOuterSpace,
      ),
    );
  }
}
