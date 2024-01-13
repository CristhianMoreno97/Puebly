import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final vPadding = width > 520 ? 40.0 : 16.0;
    final vPadding2 = width > 430 ? 32.0 : 16.0;
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: vPadding2 * 3.2,
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
                  Container(
                      width: width * 0.36,
                      constraints: const BoxConstraints(maxWidth: 280)),
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
            alignment: Alignment.bottomRight,
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
