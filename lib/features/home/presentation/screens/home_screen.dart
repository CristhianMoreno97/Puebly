import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/auxiliary_webview_providers.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/towns_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';
import 'package:puebly/features/home/presentation/widgets/custom_button_appbar.dart';
import 'package:puebly/features/home/presentation/widgets/custom_home_card.dart';
import 'package:puebly/features/home/presentation/widgets/custom_town_grid_card.dart';

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
        padding: const EdgeInsets.symmetric(horizontal: 16),
        alignment: Alignment.centerLeft,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHomeCard(),
            SizedBox(height: 16),
            Text(
              "Pueblos",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorManager.pueblyPrimary2a,
              ),
            ),   
            Text(
              "Próximamente tú municipio en Puebly.",
              style: TextStyle(
                fontSize: 12,
                //fontWeight: FontWeight.bold,
                color: ColorManager.pueblyPrimary2a,
              ),
            ),
            SizedBox(height: 4),      
            /*RichText(
              text: const TextSpan(
                text:
                    'Bienvenido a Puebly, \nencuentra la información de tu',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: ' Pueblo',
                    style: TextStyle(
                      color: ColorManager.secondaryShade1,
                    ),
                  ),
                  TextSpan(
                    text: ' en un solo lugar.[mensaje-pendiente]',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            )*/
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
                  buildSectionButton(
                      "-", icon ?? Icons.abc, index, webViewPath),
                ]),
          ),
        ),
      );
    }

    final towns = ref.watch(townsProvider).towns;

    Widget buildHomeGridButtons() {
      return MasonryGridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(8),
          itemCount: towns.length,
          itemBuilder: (context, index) {
            final town = towns[index];
            return CustomTownGridCard(
              title: town.name,
              description: town.description,
              imagePath: town.imagePath,
              townId: town.id,
              enabled: town.enabled,
            );
          });
    }

    Widget buildHomeSection() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          buildHomeHeader(),
          Expanded(child: buildHomeGridButtons()),
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
