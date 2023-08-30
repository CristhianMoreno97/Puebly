import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/config/theme/style_manager.dart';
import 'package:puebly/features/home/presentation/navigation_drawer_item.dart';
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

  int webViewLoadingProgress = 0;

  void _updateWebviewContentLoadPercentage(int progress) {
    setState(() {
      webViewLoadingProgress = progress;
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

  IconButton menuButton() {
    return IconButton(
      icon: const Icon(
        Icons.menu,
        size: 40,
        color: Colors.white,
      ),
      onPressed: () {
        Utils.drawerOpener(context, _scaffoldKey);
      },
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
    );
  }

  final List<NavigationDrawerItem> drawerItems = [
    NavigationDrawerItem(
        label: 'Inicio',
        urlPath: '/',
        icon: const Icon(Icons.home_outlined),
        selectedIcon: const Icon(Icons.home)),
    NavigationDrawerItem(
        label: 'Empleo',
        urlPath: '/app-empleo',
        icon: const Icon(Icons.work_outline_outlined),
        selectedIcon: const Icon(Icons.work_outlined)),
    NavigationDrawerItem(
        label: 'Plaza',
        urlPath: '/app-plaza',
        icon: const Icon(Icons.shopping_basket_outlined),
        selectedIcon: const Icon(Icons.shopping_basket_rounded)),
    NavigationDrawerItem(
        label: 'Comercio',
        urlPath: '/app-comercio',
        icon: const Icon(Icons.storefront_outlined),
        selectedIcon: const Icon(Icons.storefront_rounded)),
    NavigationDrawerItem(
        label: 'Turismo',
        urlPath: '/app-turismo',
        icon: const Icon(Icons.place_outlined),
        selectedIcon: const Icon(Icons.place_rounded)),
  ];

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
            menuButton(),
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
          if (index < drawerItems.length) {
            final path = drawerItems[index].urlPath;
            _changeWebViewPath(path);
          }
        },
        children: <Widget>[
          const SizedBox(height: 16),
          ...drawerItems.map((item) => NavigationDrawerDestination(
              label: Text(item.label),
              icon: item.icon,
              selectedIcon: item.selectedIcon)),
          const SizedBox(height: 16),
          _WhatsappButton(_scaffoldKey),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (webViewLoadingProgress < 100)
            LinearProgressIndicator(value: webViewLoadingProgress / 100),
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
        style: StyleManager.whatsappButtonStyle(context,
            bgColor: ColorManager.secondary),
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
