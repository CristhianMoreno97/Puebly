import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:puebly/config/constants/enviroment.dart';
import 'package:puebly/config/theme/color_manager.dart';
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
  late WebViewController _webViewController;
  int navDrawerIndex = 0;
  int webviewContentLoadPercentage = 0;

  void _drawerCloser() {
    if (_scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(context);
    }
  }

  void _navigateToPath(String path) {
    final url = Uri.parse('${Enviroment.webUrl}$path');
    _webViewController.loadRequest(url);
    _drawerCloser();
  }

  @override
  void initState() {
    final homeUrl = Uri.parse(Enviroment.webUrl);
    final WebViewController controller = WebViewController();

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(homeUrl)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(
              () {
                webviewContentLoadPercentage = 0;
              },
            );
          },
          onProgress: (int progress) {
            setState(
              () {
                webviewContentLoadPercentage = progress;
              },
            );
          },
          onPageFinished: (String url) {
            setState(
              () {
                webviewContentLoadPercentage = 100;
              },
            );
          },
        ),
      );

    _webViewController = controller;

    super.initState(); // ??? en que momento es adecuado ejecutar esto?
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: ColorManager.colorSeed,
        toolbarHeight: 64,
        title: Container(
          height: 40,
          decoration: const BoxDecoration(
            image: DecorationImage(
                alignment: Alignment(-0.25, 0),
                image: AssetImage('assets/images/logo-puebly.png')),
          ),
        ),
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
              _navigateToPath('/');
              break;
            case 1:
              _navigateToPath('/empleo');
              break;
            case 2:
              _navigateToPath('/plaza');
              break;
            case 3:
              _navigateToPath('/Comercio');
              break;
            case 4:
              _navigateToPath('/Turismo');
              break;
            default:
          }
        },
        children: const <Widget>[
          SizedBox(height: 16),
          NavigationDrawerDestination(
            label: Text('Inicio'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDrawerDestination(
            label: Text('Empleo'),
            icon: Icon(Icons.work_outline_outlined),
            selectedIcon: Icon(Icons.work_outlined),
          ),
          NavigationDrawerDestination(
            label: Text('Plaza'),
            icon: Icon(Icons.shopping_basket_outlined),
            selectedIcon: Icon(Icons.shopping_basket_rounded),
          ),
          NavigationDrawerDestination(
            label: Text('Comercio'),
            icon: Icon(Icons.storefront_outlined),
            selectedIcon: Icon(Icons.storefront_rounded),
          ),
          NavigationDrawerDestination(
            label: Text('Turismo'),
            icon: Icon(Icons.place_outlined),
            selectedIcon: Icon(Icons.place_rounded),
          ),
          SizedBox(height: 16),
          _WhatsappButton(),
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
  const _WhatsappButton();

  Future<void> launchWhatsapp(BuildContext context) async {
    var whatsapp = "+573124270705";
    var whatsappAndroid =
        Uri.parse("whatsapp://send?phone=$whatsapp&text=Hola Puebly");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      if (context.mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('La aplicación de WhatsApp no está instalada.'),
            backgroundColor: Colors.red,
          ),
        );
      }
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
        onPressed: () => launchWhatsapp(context),
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
