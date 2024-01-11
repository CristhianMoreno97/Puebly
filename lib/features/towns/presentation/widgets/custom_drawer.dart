import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/webview_providers.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      left: false,
      child: Drawer(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
        ),
        child: _DrawerView(),
      ),
    );
  }
}

class _DrawerView extends StatelessWidget {
  const _DrawerView();

  final topDrawerItems = const [
    DrawerItemInfo(
        label: 'pueblos',
        icon: Icons.home_filled,
        routeType: 'go-route',
        path: '/towns')
  ];

  final remainingDrawerItems = const [
    DrawerItemInfo(
        label: 'Acerca de nosotros',
        icon: Icons.info_rounded,
        routeType: 'webview',
        path: 'acerca-de-nosotros'),
    DrawerItemInfo(
        label: 'Contacto',
        icon: FontAwesomeIcons.whatsapp,
        routeType: 'link-app',
        path: 'whatsapp://send?phone=+573124270705&text=Hola Puebly, '),
    // DrawerItemInfo(
    //     label: 'Política de privacidad',
    //     icon: Icons.privacy_tip_rounded,
    //     routeType: 'webview',
    //     path: 'politica-de-privacidad'),
    // DrawerItemInfo(
    //     label: 'Términos y condiciones',
    //     icon: Icons.description_rounded,
    //     routeType: 'webview',
    //     path: 'terminos-y-condiciones'),
    // DrawerItemInfo(
    //     label: 'Preguntas frecuentes',
    //     icon: Icons.question_answer_rounded,
    //     routeType: 'webview',
    //     path: 'preguntas-frecuentes'),
  ];

  final socialNetworkDrawerItems = const [
    DrawerItemInfo(
        label: 'Facebook',
        icon: Icons.facebook_outlined,
        routeType: 'link-app',
        path: 'https://m.facebook.com/profile.php?id=100093991082104'),
    DrawerItemInfo(
        label: 'Instagram',
        icon: FontAwesomeIcons.instagram,
        routeType: 'link-app',
        path: 'https://instagram.com/puebly_oficial'),
    DrawerItemInfo(
        label: 'TikTok',
        icon: FontAwesomeIcons.tiktok,
        routeType: 'link-app',
        path: 'https://www.tiktok.com/@puebly_oficial'),
    DrawerItemInfo(
        label: 'Youtube',
        icon: FontAwesomeIcons.youtube,
        routeType: 'link-app',
        path: 'https://youtube.com/@Puebly'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(24),
      color: Colors.black,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const _DrawerHeader(),
          const Divider(color: Colors.white),
          ...topDrawerItems.map((e) => DrawerItem(e)).toList(),
          const Divider(color: Colors.white),
          ...remainingDrawerItems.map((e) => DrawerItem(e)).toList(),
          const Divider(color: Colors.white),
          ...socialNetworkDrawerItems.map((e) => DrawerItem(e)).toList(),
        ],
      ),
    );
  }
}

class DrawerItem extends ConsumerWidget {
  final DrawerItemInfo drawerItemInfo;

  const DrawerItem(this.drawerItemInfo, {super.key});

  void launchLinkApp({required Uri url}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: Icon(
        drawerItemInfo.icon,
        color: ColorManager.colorSeed,
      ),
      title: Text(
        drawerItemInfo.label,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        switch (drawerItemInfo.routeType) {
          case 'go-route':
            Navigator.pop(context);
            context.go(drawerItemInfo.path);
            break;
          case 'link-app':
            launchLinkApp(url: Uri.parse(drawerItemInfo.path));
            break;
          case 'webview':
            Navigator.pop(context);
            ref.read(webViewPathProvider.notifier).state = drawerItemInfo.path;
            context.push('/webview');
          default:
        }
      },
    );
  }
}

class DrawerItemInfo {
  final String label;
  final IconData icon;
  final String routeType;
  final String path;

  const DrawerItemInfo({
    required this.label,
    required this.icon,
    required this.routeType,
    required this.path,
  });
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/logo-puebly.png'),
            colorFilter:
                ColorFilter.mode(ColorManager.colorSeed, BlendMode.srcATop)),
      ),
    );
  }
}
