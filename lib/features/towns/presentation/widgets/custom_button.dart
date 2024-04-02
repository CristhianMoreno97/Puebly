import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final linearGradient = const LinearGradient(colors: [
    ColorManager.pueblyPrimary1,
    ColorManager.pueblyPrimary2,
  ]);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          gradient: linearGradient,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: _ItemText(text),
      ),
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
