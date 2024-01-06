import 'package:flutter/material.dart';
import 'package:puebly/features/home/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';

class TownSectionsScreen extends StatelessWidget {
  final String townId;
  const TownSectionsScreen({super.key, required this.townId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: Text(townId),
    );
  }
}


