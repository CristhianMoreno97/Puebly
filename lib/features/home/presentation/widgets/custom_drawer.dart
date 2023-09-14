import 'package:flutter/material.dart';
import 'package:puebly/features/home/presentation/drawer_item.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerItems = <DrawerItem>[
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

    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo-puebly.png'),
                  alignment: Alignment(-0.25, 0),
                ),
              ),
              child: null,
            ),
            ...drawerItems.map((item) {
              return ListTile(
                leading: Icon(
                  item.icon,
                  color: Colors.white,
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
              leading: const Icon(
                Icons.phone_outlined,
                color: Colors.white,
              ),
              title: const Text(
                'Contacto',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              title: const Text(
                'Acerca de',
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