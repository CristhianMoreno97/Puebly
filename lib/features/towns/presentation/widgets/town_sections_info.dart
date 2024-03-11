import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class TownSectionsInfo {
  static List<SectionInfo> get sections => const [
        SectionInfo(
          name: 'Comercio',
          selectedIcon: Icons.storefront_rounded,
          unselectedIcon: Icons.storefront_outlined,
          categoryId: 3,
          featuredImage: 'assets/images/1.Comercio.jpg',
          color: ColorPalette4.color7,
          description: 'Conoce los mejores restaurantes, tiendas, hoteles y negocios locales.',
          filterTitle: 'Seleccionar categorías',
          adText: '¿Aún no está tu negocio?',
          adButtonText: '!Publícalo aquí!'
        ),
        SectionInfo(
          name: 'Turismo',
          selectedIcon: Icons.place_rounded,
          unselectedIcon: Icons.place_outlined,
          categoryId: 4,
          featuredImage: 'assets/images/2.Turismo.jpg',
          color: ColorPalette4.color6,
          description: 'Explora los puntos turísticos que ofrece nuestro hermoso municipio.',
          filterTitle: 'Seleccionar categorías',
        ),
        SectionInfo(
          name: 'Plaza',
          selectedIcon: Icons.shopping_basket_rounded,
          unselectedIcon: Icons.shopping_basket_outlined,
          categoryId: 7,
          featuredImage: 'assets/images/3.Plaza_1.jpg',
          color: ColorPalette4.color5,
          description: 'Consigue una amplia variedad de hortalizas, tubérculos, hierbas y animales, al por mayor y al detalle.',
          filterTitle: 'Seleccionar categorías',
          adText: '¿Quieres ofrecer tus productos?',
          adButtonText: '¡Hazlo aquí!'
        ),
        SectionInfo(
          name: 'Empleo',
          selectedIcon: Icons.work_outlined,
          unselectedIcon: Icons.work_outline_outlined,
          categoryId: 5,
          featuredImage: 'assets/images/4.Empleo.jpg',
          color: ColorPalette4.color4,
          description: 'Encuentra ofertas de trabajo por jornal en diversas tareas del campo.',
          filterTitle: 'Seleccionar categorías',
          adText: '¿Tienes una oferta de empleo?',
          adButtonText: 'Contáctanos'
        ),
        SectionInfo(
          name: 'Anuncios',
          selectedIcon: Icons.sell_rounded,
          unselectedIcon: Icons.sell_outlined,
          categoryId: 35,
          featuredImage: 'assets/images/5.Anuncios.jpg',
          color: ColorPalette4.color3,
          description: 'Infórmate sobre servicios de finca raíz, acarreos, construcción, aseo, maquinaria y mucho más.',
          filterTitle: 'Seleccionar categorías',
          adText: '¿Tienes algo que anunciar?',
          adButtonText: 'Publica aquí',
        ),
        SectionInfo(
          name: 'Comunidad',
          selectedIcon: Icons.group_rounded,
          unselectedIcon: Icons.group_outlined,
          categoryId: 36,
          featuredImage: 'assets/images/Comunidad.jpg',
          color: ColorPalette4.color2,
          description: 'Entérate de anuncios de la alcaldía, fechas del pago adulto mayor, entre otros.',
          filterTitle: 'Seleccionar categorías',
        ),
        SectionInfo(
          name: 'Sabías que',
          selectedIcon: Icons.menu_book_rounded,
          unselectedIcon: Icons.menu_book_rounded,
          categoryId: 37,
          featuredImage: 'assets/images/6.sabias_que.jpg',
          color: ColorPalette4.color1,
          description: 'Descubre datos interesantes y curiosos sobre nuestro municipio y su historia.',
          filterTitle: 'Seleccionar categorías',
        ),
      ];

  static SectionInfo? getByCategoryId(int categoryId) {
    return sections.firstWhere((element) => element.categoryId == categoryId,
        orElse: () => const SectionInfo(
              name: '',
              selectedIcon: Icons.error,
              unselectedIcon: Icons.error,
              categoryId: 0,
              featuredImage: '',
              color: Colors.white,
              description: '',
              filterTitle: '',
            ));
  }

  static SectionInfo? getByIndex(int index) {
    return sections[index];
  }
}

class SectionInfo {
  final String name;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int categoryId;
  final String featuredImage;
  final Color color;
  final String description;
  final String filterTitle;
  final String? adText;
  final String? adButtonText;

  const SectionInfo({
    required this.name,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.categoryId,
    required this.featuredImage,
    required this.color,
    required this.description,
    required this.filterTitle,
    this.adText,
    this.adButtonText,
  });
}
