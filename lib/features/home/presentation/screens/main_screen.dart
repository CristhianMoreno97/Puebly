import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/config/theme/style_manager.dart';
import 'package:puebly/features/home/presentation/navigation_drawer_item.dart';
import 'package:puebly/features/home/presentation/providers/is_dark_mode_provider.dart';
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

class WebViewWithDrawer extends ConsumerStatefulWidget {
  const WebViewWithDrawer({super.key});

  @override
  WebViewWithDrawerState createState() => WebViewWithDrawerState();
}

class WebViewWithDrawerState extends ConsumerState<WebViewWithDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int webViewLoadingProgress = 0;

  void _updateWebviewLoadingProgress(int progress) {
    setState(() {
      webViewLoadingProgress = progress;
    });
  }

  NavigationDelegate _controllerNavigationDelegate() {
    return NavigationDelegate(
      onPageStarted: (_) {
        _updateWebviewLoadingProgress(0);
      },
      onProgress: (int progress) {
        _updateWebviewLoadingProgress(progress);
      },
      onPageFinished: (_) {
        _updateWebviewLoadingProgress(100);
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

  Widget _buildHomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHomeHeader(),
        Expanded(child: _buildHomeButtons()),
      ],
    );
  }

  Widget _buildHomeHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.blue,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "¡Bienvenido a Puebly!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Descubre Boyacá en Cada Rincón.",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeButtons() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          _buildSectionButton(
              "Comercio", Icons.storefront_outlined, '/app-comercio', 1),
          _buildSectionButton(
              "Plaza", Icons.shopping_basket_outlined, '/app-plaza', 2),
          _buildSectionButton(
              "Empleo", Icons.work_outline_outlined, '/app-empleo', 3),
          _buildSectionButton(
              "Turismo", Icons.place_outlined, '/app-turismo', 4),
        ],
      ),
    );
  }

  Widget _buildSectionButton(
      String label, IconData icon, String urlPath, int index) {
    return ElevatedButton(
      onPressed: () {
        _changeWebViewPath(urlPath);
        setState(() {
          navDrawerIndex = index;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          ),
        ],
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
        label: 'Comercio',
        urlPath: '/app-comercio',
        icon: const Icon(Icons.storefront_outlined),
        selectedIcon: const Icon(Icons.storefront_rounded)),
    NavigationDrawerItem(
        label: 'Plaza',
        urlPath: '/app-plaza',
        icon: const Icon(Icons.shopping_basket_outlined),
        selectedIcon: const Icon(Icons.shopping_basket_rounded)),
    NavigationDrawerItem(
        label: 'Empleo',
        urlPath: '/app-empleo',
        icon: const Icon(Icons.work_outline_outlined),
        selectedIcon: const Icon(Icons.work_outlined)),
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

  Widget _darkModeButton(bool isDarkMode) {
    return SizedBox(
      height: 64,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            isDarkMode ? Colors.black : Colors.white,
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        child: Icon(
          isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
          size: 32,
        ),
        onPressed: () {
          ref.read(isDarkModeProvider.notifier).update((state) => !state);
        },
      ),
    );
  }

  int navDrawerIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(isDarkModeProvider);
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
        selectedIndex: navDrawerIndex,
        backgroundColor:
            Theme.of(context).navigationDrawerTheme.backgroundColor,
        elevation: Theme.of(context).navigationDrawerTheme.elevation,
        shadowColor: Theme.of(context).navigationDrawerTheme.shadowColor,
        surfaceTintColor:
            Theme.of(context).navigationDrawerTheme.surfaceTintColor,
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
          const SizedBox(height: 80),
          Row(children: [_darkModeButton(isDarkMode)]),
        ],
      ),
      body: Stack(
        children: [
          if (navDrawerIndex == 0)
            _buildHomeSection()
          else ...[
            WebViewWidget(controller: _webViewController),
            if (webViewLoadingProgress < 100)
              LinearProgressIndicator(value: webViewLoadingProgress / 100)
          ],
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
        style: StyleManager.whatsappButtonStyle(
          context,
          bgColor: ColorManager.secondary,
        ),
        onPressed: () => _launchWhatsapp(context, message: 'Hola Puebly, '),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 24),
            const FaIcon(
              FontAwesomeIcons.whatsapp,
              color: Colors.white,
              size: 56,
            ),
            const SizedBox(width: 16),
            Text(
              'Comunicate con Puebly',
              style: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
