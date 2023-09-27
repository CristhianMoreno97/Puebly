import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

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

    Widget buildSectionButton(String label, IconData icon, int index) {
      return ElevatedButton(
        onPressed: () {
          goToSection(index);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 40,
              color: ColorPalette1.color1,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: ColorPalette1.color1,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    Widget buildHomeHeaderContent() {
      return Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.centerLeft,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "¡Bienvenido a Puebly!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Descubre Boyacá en Cada Rincón.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    Widget buildWaveLayer({
      required CustomClipper<Path> clipper,
      required Color color,
      required double height,
    }) {
      return ClipPath(
        clipper: clipper,
        child: Container(
          color: color,
          height: height,
        ),
      );
    }

    Widget buildHomeHeader() {
      return Stack(
        children: [
          buildWaveLayer(
            clipper: WaveClipperOne(),
            color: ColorPalette1.color1,
            height: 150,
          ),
          buildHomeHeaderContent(),
        ],
      );
    }

    Widget buildHomeButtons() {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 24,
          crossAxisSpacing: 24,
          children: [
            buildSectionButton("Comercio", Icons.storefront_outlined, 0),
            buildSectionButton("Turismo", Icons.place_outlined, 1),
            buildSectionButton("Plaza", Icons.shopping_basket_outlined, 2),
            buildSectionButton("Empleo", Icons.work_outline_outlined, 3),
          ],
        ),
      );
    }

    Widget buildHomeSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHomeHeader(),
          Expanded(child: buildHomeButtons()),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorPalette1.color1,
          title: const Padding(
            padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
            child: AppBarTitle(),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      body: SafeArea(
        child: buildHomeSection(),
      ),
    );
  }
}
