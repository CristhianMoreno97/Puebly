import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final vPadding = width > 600 ? 32.0 : 16.0;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: width * 0.14,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: vPadding),
              decoration: BoxDecoration(
                color: ColorManager.pueblySecundary1,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Flexible(child: _WelcomeText()),
                  SizedBox(width: width * 0.36),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          width: width * 0.4,
          child: Image.asset(
            'assets/images/traveler-woman-lowr.png',
            alignment: Alignment.bottomCenter,
          ),
        ),
      ],
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '¡Hola!\n',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Colors.white),
        children: [
          TextSpan(
              text: 'Te damos la bienvenida a la aplicación creada para ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white)),
          TextSpan(
            text: 'fortalecer',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: ' la economía de nuestros',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white)),
          TextSpan(
            text: ' pueblos campesinos',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          TextSpan(
              text: '. ',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white)),
        ],
      ),
    );
  }
}
