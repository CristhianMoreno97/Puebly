import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/providers/webview_providers.dart';

class CustomTownCard extends ConsumerWidget {
  const CustomTownCard({
    super.key,
    required this.name,
    required this.description,
    required this.hexColor,
    required this.id,
    required this.enabled,
    required this.imagePath,
  });

  final String name;
  final String description;
  final String hexColor;
  final String id;
  final bool enabled;
  final String? imagePath;

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

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imagePath != null 
                  ? NetworkImage("${EnviromentConstants.homeURL}/$imagePath") as ImageProvider
                  : const AssetImage('assets/images/placeholder_1.jpg'),
                fit: BoxFit.cover,
              ),
              //color: Color(int.parse("0xFF$hexColor")),
              //color: Color(int.parse(hexColor)),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          GestureDetector(
            onTap: () {
              ref.read(townParameter.notifier).state = id;
              goToSection(0);
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
