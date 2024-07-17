import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class CustomSecundaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const CustomSecundaryButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: FilledButton.icon(
        onPressed: onTap,
        label: Text(text),
        icon: const Icon(Icons.filter_alt, color: ColorManager.blueOuterSpace),
        iconAlignment: IconAlignment.start,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
              side: const BorderSide(color: ColorManager.blueOuterSpaceTint6),
            ),
          ),
          foregroundColor: WidgetStateProperty.all(ColorManager.blueOuterSpace),
          textStyle: WidgetStateProperty.all(
            Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: ColorManager.blueOuterSpace),
          ),
        ),
      ),
    );
  }
}
