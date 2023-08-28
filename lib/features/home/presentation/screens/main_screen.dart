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
  int loadingPercentage = 0;

  void _navigateToPath(String path) {
    _webViewController.loadRequest(
      Uri.parse('${Enviroment.webUrl}$path'),
    );
    Navigator.pop(context); // Cierra el NavigationDrawer
  }

  @override
  void initState() {
    super.initState();
    final WebViewController controller = WebViewController();
    controller
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            loadingPercentage = 0;
          });
        },
        onProgress: (int progress) {
          setState(() {
            loadingPercentage = progress;
          });
        },
        onPageFinished: (String url) {
          setState(() {
            loadingPercentage = 100;
          });
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(Enviroment.webUrl))
      ..setBackgroundColor(Colors.white);
    _webViewController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment(-0.25, 0),
              image: AssetImage(
                  'assets/images/logo-puebly.png'), // Reemplaza 'ruta_de_la_imagen' con la ruta de tu imagen personalizada
            ),
          ),
        ),
        backgroundColor: ColorManager.colorSeed,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState!.openDrawer();
          },
        ),
      ),
      drawer: NavigationDrawer(
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
          DrawerHeader(
            decoration: BoxDecoration(
                //color: Colors.blue,
                ),
            child: Text(
              'Secciones',
              style: TextStyle(
                //color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          NavigationDrawerDestination(
            label: Text('Inicio'),
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
          ),
          NavigationDrawerDestination(
            label: Text('empleo'),
            icon: Icon(Icons.work_outline_outlined),
            selectedIcon: Icon(Icons.work_outlined),
          ),
          NavigationDrawerDestination(
            label: Text('plaza'),
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
          SizedBox(height: 64),
          _WhatsappButton(),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(
            controller: _webViewController,
          ),
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100,
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
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            ColorManager.secondary,
          ),
        ),
        onPressed: () => launchWhatsapp(context),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
            SizedBox(width: 10),
            Text('Chatea con nosotros', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
