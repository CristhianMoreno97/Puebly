import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/drawer_item.dart';
import 'package:puebly/features/home/presentation/providers/auxiliary_webview_providers.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topDrawerItems = <DrawerItem>[
      DrawerItem(
        label: 'Inicio',
        urlPath: null,
        icon: Icons.home_filled,
        selectedIcon: Icons.home,
      ),
      DrawerItem(
        label: 'Comunidad',
        urlPath: 'app-comunidad',
        icon: Icons.group_rounded,
        selectedIcon: Icons.group_rounded,
      ),
      DrawerItem(
        label: 'Clasificados',
        urlPath: 'app-clasificados',
        icon: Icons.sell_rounded,
        selectedIcon: Icons.sell_rounded,
      ),
      DrawerItem(
        label: 'Sabías que...',
        urlPath: 'app-sabias-que',
        icon: Icons.menu_book_rounded,
        selectedIcon: Icons.explore_outlined,
      ),
    ];

    const drawerHeader = DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(ColorPalette1.color1a, BlendMode.srcATop),
          image: AssetImage('assets/images/logo-puebly.png'),
          alignment: Alignment(-0.25, 0),
        ),
      ),
      child: null,
    );

    buildTopDrawerItem(DrawerItem item) {
      return ListTile(
        leading: Icon(
          item.icon,
          color: ColorManager.colorSeed,
        ),
        title: Text(
          item.label,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          Navigator.pop(context);
          final webViewPath = item.urlPath;

          if (webViewPath == null) {
            ref.read(showHomeScreenProvider.notifier).state = true;
            return;
          }
          ref.read(auxiliaryWebViewPathProvider.notifier).state = webViewPath;
          context.push('/auxiliary-screen');
        },
      );
    }

    Widget buildDrawerItem({
      required IconData iconData,
      required String label,
      required Function onTap,
      bool isFaIcon = false,
    }) {
      const iconColor = ColorManager.colorSeed;
      final icon = isFaIcon
          ? FaIcon(iconData, color: iconColor)
          : Icon(iconData, color: iconColor);

      return ListTile(
        leading: icon,
        title: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          onTap();
          Navigator.pop(context);
        },
      );
    }

    onTapDrawerItem() {
      print('tap');
    }

    final drawerContent = ListView(
      padding: EdgeInsets.zero,
      children: [
        drawerHeader,
        ...topDrawerItems.map((item) => buildTopDrawerItem(item)),
        const Divider(color: Colors.white),
        buildDrawerItem(
          iconData: Icons.info_rounded,
          label: 'Acerca de nosotros',
          onTap: onTapDrawerItem,
        ),
        buildDrawerItem(
          iconData: FontAwesomeIcons.whatsapp,
          label: 'Whatsapp',
          onTap: onTapDrawerItem,
          isFaIcon: true,
        ),
        const Divider(color: Colors.white),
        buildDrawerItem(
          iconData: Icons.facebook_outlined,
          label: 'Facebook',
          onTap: onTapDrawerItem,
        ),
        buildDrawerItem(
          iconData: FontAwesomeIcons.instagram,
          label: 'Instagram',
          onTap: onTapDrawerItem,
          isFaIcon: true,
        ), // instagram
        buildDrawerItem(
          iconData: FontAwesomeIcons.tiktok,
          label: 'TikTok',
          onTap: onTapDrawerItem,
          isFaIcon: true,
        ), // instagram
        buildDrawerItem(
          iconData: FontAwesomeIcons.youtube,
          label: 'Youtube',
          onTap: onTapDrawerItem,
          isFaIcon: true,
        ),
      ],
    );
    final drawerView = Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black87,
          ],
        ),
      ),
      //color: Colors.black,
      child: drawerContent,
    );
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: drawerView,
    );
  }
}
