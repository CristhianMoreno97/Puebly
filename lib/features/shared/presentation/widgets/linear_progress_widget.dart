import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class LinearProgressWidget extends StatelessWidget {
  const LinearProgressWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LinearProgressIndicator(
          color: ColorManager.colorSeed,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
