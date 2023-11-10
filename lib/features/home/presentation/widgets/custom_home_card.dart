import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class CustomHomeCard extends StatelessWidget {
  const CustomHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Column(
          children: [
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: ColorManager.pueblySecundary1,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '¡Hola!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Flexible(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                  text:
                                      'Te damos la bienvenida a la aplicación creada para ',
                                ),
                                TextSpan(
                                  text: 'fortalecer',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: ' la economía de nuestros',
                                ),
                                TextSpan(
                                  text: ' pueblos campesinos',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: '.',
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: width * 0.28),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/images/traveler-woman-lowr.png',
            width: width * 0.28,
          ),
        ),
      ],
    );
  }
}
