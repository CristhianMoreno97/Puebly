import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: WebViewWithDrawer());
  }
}

class WebViewWithDrawer extends StatefulWidget {
  const WebViewWithDrawer({super.key});

  @override
  State<WebViewWithDrawer> createState() => _WebViewWithDrawerState();
}

class _WebViewWithDrawerState extends State<WebViewWithDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int webviewContentLoadPercentage = 0;

  void _updateWebviewContentLoadPercentage(int progress) {
    setState(() {
      webviewContentLoadPercentage = progress;
    });
  }

  NavigationDelegate _controllerNavigationDelegate() {
    return NavigationDelegate(
      onPageStarted: (_) {
        _updateWebviewContentLoadPercentage(0);
      },
      onProgress: (int progress) {
        _updateWebviewContentLoadPercentage(progress);
      },
      onPageFinished: (_) {
        _updateWebviewContentLoadPercentage(100);
      },
    );
  }

  late WebViewController _webViewController;

  @override
  void initState() {
    final homeUrl = Uri.parse(EnviromentConstants.webUrl);
    final WebViewController controller = WebViewController();

    controller
      ..loadRequest(homeUrl)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(_controllerNavigationDelegate());

    _webViewController = controller;

    super.initState(); // ??? en que momento es adecuado ejecutar esto?
  }

  static const DecorationImage headerImage = DecorationImage(
    image: AssetImage('assets/images/logo-puebly.png'),
    alignment: Alignment(-0.25, 0),
  );

  final Widget _header = Container(
    height: 40,
    decoration: const BoxDecoration(
      image: headerImage,
    ),
  );

  void _changeWebViewPath(String path) {
    final url = Uri.parse('${EnviromentConstants.webUrl}$path');
    _webViewController.loadRequest(url);
    Utils.drawerCloser(context, _scaffoldKey);
  }

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorManager.colorSeed,
        toolbarHeight: 64,
        title: _header,
        leadingWidth: 64,
        leading: Row(
          children: [
            const SizedBox(width: 8),
            IconButton.filled(
              padding: const EdgeInsets.all(8),
              visualDensity: VisualDensity.compact,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black,
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              icon: const Icon(
                Icons.menu,
                size: 40,
                color: Colors.white,
              ),
              onPressed: () {
                _scaffoldKey.currentState!.openDrawer();
              },
            ),
          ],
        ),
      ),
      drawer: NavigationDrawer(
        //backgroundColor: ColorManager.background,
        selectedIndex: navDrawerIndex,
        elevation: 1,
        onDestinationSelected: (index) {
          setState(() {
            navDrawerIndex = index;
          });
          switch (index) {
            case 0:
              _changeWebViewPath('/');
              break;
            case 1:
              _changeWebViewPath('/empleo');
              break;
            case 2:
              _changeWebViewPath('/plaza');
              break;
            case 3:
              _changeWebViewPath('/Comercio');
              break;
            case 4:
              _changeWebViewPath('/Turismo');
              break;
            default:
          }
        },
        children: <Widget>[
          const SizedBox(height: 16),
          const NavigationDrawerDestination(
            label: Text('Inicio'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          const NavigationDrawerDestination(
            label: Text('Empleo'),
            icon: Icon(Icons.work_outline_outlined),
            selectedIcon: Icon(Icons.work_outlined),
          ),
          const NavigationDrawerDestination(
            label: Text('Plaza'),
            icon: Icon(Icons.shopping_basket_outlined),
            selectedIcon: Icon(Icons.shopping_basket_rounded),
          ),
          const NavigationDrawerDestination(
            label: Text('Comercio'),
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded),
          ),
          const NavigationDrawerDestination(
            label: Text('Turismo'),
            icon: Icon(Icons.place_outlined),
            selectedIcon: Icon(Icons.place_rounded),
          ),
          const SizedBox(height: 16),
          _WhatsappButton(_scaffoldKey),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          if (webviewContentLoadPercentage < 100)
            LinearProgressIndicator(
              value: webviewContentLoadPercentage / 100,
            ),
        ],
      ),
    );
  }
}

class _WhatsappButton extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const _WhatsappButton(this._scaffoldKey);

  Future<void> _launchWhatsapp(BuildContext context,
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
        _scaffoldKey,
        'No se pudo abrir WhatsApp. \nAsegúrate de tener la aplicación instalada.',
        backgroundColor: Colors.red,
      );
      Utils.drawerCloser(context, _scaffoldKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorManager.secondary,
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.symmetric(vertical: 8),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        onPressed: () => _launchWhatsapp(context, message: 'Hola Puebly, '),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 24),
            FaIcon(FontAwesomeIcons.whatsapp, color: Colors.black, size: 56),
            SizedBox(width: 16),
            Text('Comunicate con Puebly',
                style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
