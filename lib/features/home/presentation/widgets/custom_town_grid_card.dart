import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/providers/webview_providers.dart';

class CustomTownGridCard extends ConsumerWidget {
  const CustomTownGridCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.townId,
    required this.enabled,
  });

  final String title;
  final String description;
  final String imagePath;
  final String townId;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void goToSection(int sectionIndex) {
      ref.read(showHomeScreenProvider.notifier).state = false;
      ref.read(pageControllerProvider.notifier).update((state) {
        state.animateToPage(sectionIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        return state;
      });
    }

    return GestureDetector(
      onTap: () {
        ref.read(townParameter.notifier).state = townId;
        ref.read(townNameProvider.notifier).state = title;
        goToSection(0);
      },
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 4,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TownImage(imagePath: imagePath),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: TextStyle(
                    color: enabled
                        ? ColorManager.pueblySecundary1
                        : ColorManager.pueblySecundary1,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  description,
                  style: TextStyle(
                    letterSpacing: 0,
                    wordSpacing: 0,
                    height: 1.2,
                    color: enabled
                        ? ColorManager.pueblyPrimary2a
                        : ColorManager.pueblyPrimary2c,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          )),
    );
  }
}

class TownImage extends StatelessWidget {
  const TownImage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final width = constraints.maxWidth;
        return Container(
          width: width,
          height: width,
          decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage("${EnviromentConstants.homeURL}/$imagePath"),
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(0),
              )),
        );
      },
    );
  }
}
