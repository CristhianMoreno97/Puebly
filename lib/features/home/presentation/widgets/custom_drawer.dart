import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final topDrawerItems = <DrawerItem>[
      DrawerItem(
        label: 'Inicio',
        urlPath: '/',
        icon: Icons.home_outlined,
        selectedIcon: Icons.home,
      ),
      DrawerItem(
        label: 'Comunidad',
        urlPath: '/comunidad',
        icon: Icons.group_outlined,
        selectedIcon: Icons.group_rounded,
      ),
      DrawerItem(
        label: 'Descubrir',
        urlPath: '/descubrir',
        icon: Icons.explore_outlined,
        selectedIcon: Icons.explore_outlined,
      ),
    ];

    const drawerHeader = DrawerHeader(
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(ColorPalette1.color1a, BlendMode.srcATop),
          image: AssetImage('assets/images/logo-puebly.png'),
          alignment: Alignment(-0.25, 0),
        ),
      ),
      child: null,
    );

    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Container(
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
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            drawerHeader,
            ...topDrawerItems.map((item) {
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
                  Navigator.pushNamed(context, item.urlPath);
                },
              );
            }),
            const Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: const FaIcon(
                FontAwesomeIcons.whatsapp,
                color: ColorManager.colorSeed,
              ),
              title: const Text(
                'Whatsapp',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: ColorManager.colorSeed,
              ),
              title: const Text(
                'Acerca de',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Divider(
              color: Colors.white,
            ),
            ListTile(
              leading: const Icon(
                Icons.facebook_outlined,
                color: ColorManager.colorSeed,
              ),
              title: const Text(
                'Facebook',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // instagram
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.instagram,
                color: ColorManager.colorSeed,
              ),
              title: const Text(
                'Instagram',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // tiktok
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.tiktok,
                color: ColorManager.colorSeed,
              ),
              title: const Text(
                'Tiktok',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            // youtube
            ListTile(
              leading: FaIcon(
                FontAwesomeIcons.youtube,
                color: ColorManager.colorSeed,
              ),
              title: const Text(
                'Youtube',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),            
          ],
        ),
      ),
    );
  }
}