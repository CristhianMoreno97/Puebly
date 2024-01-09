import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';
import 'package:puebly/features/towns/utils/section_utils.dart';

class SectionsBottomNavBar extends ConsumerWidget {
  const SectionsBottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(sectionIndexProvider);
    return BottomAppBar(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.white,
      height: 72,
      elevation: 0,
      child: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: ref.watch(sectionsScrollControllerProvider),
          child: Row(
            children: [
              for (int index = 0;
                  index < TownSectionsInfo.sections.length;
                  index++)
                _NavBarItem(
                  sectionInfo: TownSectionsInfo.sections[index],
                  isSelected: index == selectedIndex,
                  onTap: () => SectionUtils.navigateTo(index, ref, context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final SectionInfo sectionInfo;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.sectionInfo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final icon =
        isSelected ? sectionInfo.selectedIcon : sectionInfo.unselectedIcon;
    final iconColor = isSelected ? Colors.white : ColorManager.pueblyPrimary1;
    final itemColor = isSelected
        ? const LinearGradient(
            colors: [
              ColorManager.pueblyPrimary1,
              ColorManager.pueblyPrimary2,
            ],
          )
        : null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: itemColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Row(
          children: [
            _ItemIcon(icon, color: iconColor, enableShadow: isSelected),
            isSelected ? _ItemText(sectionInfo.name) : const SizedBox(),
          ],
        ),
      ),
    );
  }
}

class _ItemIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool enableShadow;

  const _ItemIcon(this.icon, {required this.color, required this.enableShadow});

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: 28,
      color: color,
      shadows: enableShadow
          ? [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ]
          : null,
    );
  }
}

class _ItemText extends StatelessWidget {
  final String text;

  const _ItemText(this.text);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 96,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
