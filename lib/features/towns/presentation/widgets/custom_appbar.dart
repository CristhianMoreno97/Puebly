import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const _AppBarTitle(),
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorManager.pueblyPrimary1,
      leading: Builder(
        builder: (context) => IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 40,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Image.asset('assets/images/logo-puebly.png', height: 40),
    );
  }
}
