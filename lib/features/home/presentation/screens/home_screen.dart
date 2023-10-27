import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/auxiliary_webview_providers.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';
import 'package:puebly/features/home/presentation/widgets/custom_button_appbar.dart';

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

    Widget buildSectionButton(
        String label, IconData icon, int? index, String? webViewPath) {
      return IconButton(
        onPressed: () {},
        icon: Icon(
          icon,
          size: 32,
          color: Colors.white,
        ),
      );
    }

    Widget buildHomeHeaderContent() {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "¡Hola",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: ColorManager.colorSeedShade1,
              ),
            ),
            const Text(
              "Puebly-amigos!",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: ColorManager.colorSeedShade1,
              ),
            ),
            RichText(
              text: const TextSpan(
                text:
                    'Te damos la bienvenida a la aplicación donde encontrarás de ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'todo',
                    style: TextStyle(
                      color: ColorManager
                          .secondaryShade1,
                    ),
                  ),
                  TextSpan(
                    text: ' para todos.',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget buildHomeHeader() {
      return Stack(
        children: [
          buildHomeHeaderContent(),
        ],
      );
    }

    Widget buildCustomCard(
        Color color,
        String label,
        IconData icon,
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
                  SizedBox(
                    width: 220,
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
                        )
                      ],
                    ),
                  ),
                  buildSectionButton("-", icon, index, webViewPath),
                ]),
          ),
        ),
      );
    }

    Widget buildHomeButtons() {
      return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: [
          buildCustomCard(
              ColorPalette4.color7,
              "Comunidad",
              Icons.group_outlined,
              "Entérate de anuncios de la alcaldía, fechas del pago adulto mayor, entre otros.",
              null,
              'app-comunidad',
              'assets/images/Comunidad.jpg'),
          const SizedBox(height: 8),
          buildCustomCard(
              ColorPalette4.color6,
              "Comercio",
              Icons.storefront_outlined,
              "Conoce los mejores restaurantes, tiendas, hoteles y negocios locales.\n",
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
              "Explora los puntos turísticos que ofrece nuestro hermoso municipio.\n",
              1,
              null,
              'assets/images/Turismo.jpg'),
          const SizedBox(height: 8),
          buildCustomCard(
              ColorPalette4.color3,
              "Clasificados",
              Icons.sell_outlined,
              "Infórmate sobre servicios de finca raíz, acarreos, construcción, aseo, maquinaria y mucho más",
              null,
              'app-clasificados',
              'assets/images/Clasificados.jpg'),
          const SizedBox(height: 8),
          buildCustomCard(
              ColorPalette4.color2,
              "Empleo",
              Icons.work_outline_outlined,
              "Encuentra ofertas de trabajo por jornal en diversas tareas del campo.\n",
              3,
              null,
              'assets/images/empleo.jpg'),
          const SizedBox(height: 8),
          buildCustomCard(
              ColorPalette4.color1,
              "¿Sabías que...",
              Icons.place_outlined,
              "Descubre datos interesantes y curiosos sobre nuestro municipio y su historia.\n",
              null,
              'app-sabias-que',
              'assets/images/Sabías que.jpg'),
        ],
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
        surfaceTintColor: Colors.transparent,
        elevation: 0,
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
      bottomNavigationBar: const CustomButtonAppbar(),
    );
  }
}
