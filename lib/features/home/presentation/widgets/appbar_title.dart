import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    const DecorationImage pueblyLogo = DecorationImage(
      image: AssetImage('assets/images/logo-puebly.png'),
      alignment: Alignment(-0.25, 0),
    );
    return Container(
      height: 40,
      decoration: const BoxDecoration(
        image: pueblyLogo,
      ),
    );
  }
}