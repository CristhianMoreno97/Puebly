import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class CustomTabItem extends StatelessWidget {
  final TabInfo tabInfo;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabItem({
    super.key,
    required this.tabInfo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabColor = isSelected ? tabInfo.gradient : null;
    const textColor = Colors.white;
    final iconColor = isSelected ? Colors.white : ColorPalette1.color1;
    final boxShadow = isSelected
        ? [
            BoxShadow(
              color: tabInfo.gradient.colors[0].withOpacity(0.6),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ]
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          gradient: tabColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: boxShadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? tabInfo.iconDataSelected : tabInfo.iconData,
              color: iconColor,
              size: 34,
              shadows: isSelected
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            if (isSelected) buildTabText(textColor),
          ],
        ),
      ),
    );
  }

  Flexible buildTabText(Color textColor) {
    return Flexible(
      child: SizedBox(
        width: 88,
        child: Center(
          child: Text(
            tabInfo.label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 4,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabInfo {
  final String label;
  final IconData iconData;
  final IconData iconDataSelected;
  final LinearGradient gradient;

  TabInfo(
    this.label,
    this.iconData,
    this.iconDataSelected,
    this.gradient,
  );
}
