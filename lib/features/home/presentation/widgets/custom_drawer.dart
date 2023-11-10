import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/drawer_item.dart';
import 'package:puebly/features/home/presentation/providers/auxiliary_webview_providers.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
      /*DrawerItem(
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
      ),*/
    ];

    final drawerHeader = Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      height: 120,
      decoration: const BoxDecoration(
        image: DecorationImage(
          colorFilter:
              ColorFilter.mode(ColorManager.colorSeed, BlendMode.srcATop),
          image: AssetImage('assets/images/logo-puebly.png'),
          alignment: Alignment(-0.25, 0),
        ),
      ),
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
            ref.read(showSectionsScreenProvider.notifier).state = true;
            return;
          }
          ref.read(auxiliaryWebViewPathProvider.notifier).state = webViewPath;
          context.push('/auxiliary-screen');
        },
      );
    }

    launchLinkApp({required Uri url}) async {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    }

    Widget buildDrawerItem({
      required IconData iconData,
      required String label,
      String? androidPackageName,
      Uri? url,
      bool isFaIcon = false,
    }) {
      const iconColor = ColorManager.colorSeed;
      final icon = isFaIcon
          ? FaIcon(iconData, color: iconColor)
          : Icon(iconData, color: iconColor);

      return ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leading: icon,
        title: Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () async {
          Navigator.pop(context);
          if (url != null) {
            await launchLinkApp(url: url);
          }
        },
      );
    }

    final drawerContent = ListView(
      //padding: EdgeInsets.zero,
      children: [
        drawerHeader,
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: Colors.white),
        ),
        ...topDrawerItems.map((item) => buildTopDrawerItem(item)),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: Colors.white),
        ),

        buildTopDrawerItem(
          DrawerItem(
            label: 'Acerca de nosotros',
            urlPath: 'acerca-de-nosotros',
            icon: Icons.info_rounded,
            selectedIcon: Icons.info_rounded,
          ),
        ),

        buildDrawerItem(
          iconData: FontAwesomeIcons.whatsapp,
          label: 'Whatsapp',
          isFaIcon: true,
          url: Uri.parse(
              'whatsapp://send?phone=+573124270705&text=Hola Puebly, '),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(color: Colors.white),
        ),
        buildDrawerItem(
          iconData: Icons.facebook_outlined,
          label: 'Facebook',
          url: Uri.parse('https://m.facebook.com/profile.php?id=100093991082104')
        ),
        buildDrawerItem(
          iconData: FontAwesomeIcons.instagram,
          label: 'Instagram',
          isFaIcon: true,
          url: Uri.parse('https://instagram.com/puebly_oficial'),
        ), // instagram
        buildDrawerItem(
          iconData: FontAwesomeIcons.tiktok,
          label: 'TikTok',
          isFaIcon: true,
          url: Uri.parse('https://www.tiktok.com/@puebly_oficial')
        ), // instagram
        buildDrawerItem(
          iconData: FontAwesomeIcons.youtube,
          label: 'Youtube',
          isFaIcon: true,
          url: Uri.parse('https://youtube.com/@Puebly'),
          androidPackageName: 'com.google.android.youtube',
        ),
        // dark mode button
        /*
        Row(
          children: [
            IconButton(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                onPressed: () {},
                icon: const Icon(Icons.light_mode_rounded,
                    color: ColorManager.colorSeed))
          ],
        )*/
      ],
    );
    final drawerView = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
        gradient: LinearGradient(
          colors: [
            Colors.black,
            Colors.black,
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
