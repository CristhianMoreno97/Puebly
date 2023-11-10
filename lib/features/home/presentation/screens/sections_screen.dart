import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/auxiliary_webview_providers.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/providers/webview_providers.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';

class SectionsScreen extends ConsumerWidget {
  const SectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildSectionButton(
        String label, IconData icon, int? index, String? webViewPath) {
      return Icon(
        icon,
        size: 32,
        color: Colors.white,
      );
    }

    void goToSection(int sectionIndex) {
      ref.read(showHomeScreenProvider.notifier).state = false;
      ref.read(showSectionsScreenProvider.notifier).state = false;
      ref.read(pageControllerProvider.notifier).update((state) {
        state.animateToPage(sectionIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        return state;
      });
      double offset = sectionIndex < 3 ? 0 : sectionIndex * 32;
      ref.read(scrollControllerProvider.notifier).update((state) {
        state.animateTo(
          offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
        return state;
      });
    }

    Widget buildCustomCard(
        Color color,
        String label,
        IconData? icon,
        String description,
        int? index,
        String? webViewPath,
        String? imagePath) {
      return GestureDetector(
        onTap: () {
          if (index != null) {
            goToSection(index);
            return;
          }
          if (webViewPath != null) {
            ref.read(auxiliaryWebViewPathProvider.notifier).state = webViewPath;
            context.push('/auxiliary-screen');
          }
        },
        child: Card(
          color: color,
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // image avatar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(500),
                    child: Image.asset(
                      width: 48,
                      height: 48,
                      imagePath ?? 'assets/images/placeholder_1.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          description,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  buildSectionButton(
                      "-", icon ?? Icons.abc, index, webViewPath),
                ]),
          ),
        ),
      );
    }

    final townName = ref.watch(townNameProvider);

    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: ColorManager.pueblyPrimary1,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: AppBarTitle(),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 16),
              Text(
                "Estás en $townName",
                style: const TextStyle(
                  color: ColorManager.pueblyPrimary2a,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              buildCustomCard(
                  ColorPalette4.color7,
                  "Comunidad",
                  Icons.group_outlined,
                  "Entérate de anuncios de la alcaldía, fechas del pago adulto mayor, entre otros.",
                  5,
                  'app-comunidad',
                  'assets/images/Comunidad.jpg'),
              const SizedBox(height: 8),
              buildCustomCard(
                  ColorPalette4.color6,
                  "Comercio",
                  Icons.storefront_outlined,
                  "Conoce los mejores restaurantes, tiendas, hoteles y negocios locales.",
                  0,
                  null,
                  'assets/images/Comercio.jpg'),
              const SizedBox(height: 8),
              buildCustomCard(
                  ColorPalette4.color5,
                  "Plaza",
                  Icons.shopping_basket_outlined,
                  "Consigue una amplia variedad de hortalizas, tubérculos, hierbas y animales, al por mayor y al detalle.",
                  2,
                  null,
                  'assets/images/Plaza.jpg'),
              const SizedBox(height: 8),
              buildCustomCard(
                  ColorPalette4.color4,
                  "Turismo",
                  Icons.place_outlined,
                  "Explora los puntos turísticos que ofrece nuestro hermoso municipio.",
                  1,
                  null,
                  'assets/images/Turismo.jpg'),
              const SizedBox(height: 8),
              buildCustomCard(
                  ColorPalette4.color3,
                  "Clasificados",
                  Icons.sell_outlined,
                  "Infórmate sobre servicios de finca raíz, acarreos, construcción, aseo, maquinaria y mucho más",
                  4,
                  'app-clasificados',
                  'assets/images/Clasificados.jpg'),
              const SizedBox(height: 8),
              buildCustomCard(
                  ColorPalette4.color2,
                  "Empleo",
                  Icons.work_outline_outlined,
                  "Encuentra ofertas de trabajo por jornal en diversas tareas del campo.",
                  3,
                  null,
                  'assets/images/empleo.jpg'),
              const SizedBox(height: 8),
              buildCustomCard(
                  ColorPalette4.color1,
                  "¿Sabías que...",
                  Icons.place_outlined,
                  "Descubre datos interesantes y curiosos sobre nuestro municipio y su historia.",
                  6,
                  'app-sabias-que',
                  'assets/images/Sabías que.jpg'),
            ]),
      ),
    );
  }
}
