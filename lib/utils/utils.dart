import 'package:flutter/material.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Utils {
  static void drawerCloser(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(context);
    }
  }

  static void drawerOpener(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  static void showSnackBar(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
    String message, {
    Color backgroundColor = Colors.red,
  }) {
    if (context.mounted) {
      Utils.drawerCloser(context, scaffoldKey);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    }
  }

  static Future<void> launchPhoneCall(BuildContext context,
      GlobalKey<ScaffoldState> scaffoldKey, Uri phoneUrl) async {
    if (await canLaunchUrl(phoneUrl)) {
      await launchUrl(phoneUrl);
      return;
    }

    if (context.mounted) {
      Utils.showSnackBar(
        context,
        scaffoldKey,
        'No se pudo realizar la llamada. \nAsegúrate de tener la aplicación instalada.',
        backgroundColor: Colors.red,
      );
      Utils.drawerCloser(context, scaffoldKey);
    }
  }

  static Future<void> launchWhatsapp(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey,
      {String message = ''}) async {
    final whatsapp = EnviromentConstants.whatsappNumber;
    final whatsappAndroid =
        Uri.parse('whatsapp://send?phone=$whatsapp&text=$message');

    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
      return;
    }

    if (context.mounted) {
      Utils.showSnackBar(
        context,
        scaffoldKey,
        'No se pudo abrir WhatsApp. \nAsegúrate de tener la aplicación instalada.',
        backgroundColor: Colors.red,
      );
      Utils.drawerCloser(context, scaffoldKey);
    }
  }
}
