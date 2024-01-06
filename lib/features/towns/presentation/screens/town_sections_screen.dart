import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/sections_bottom_navbar.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSectionsScreen extends StatelessWidget {
  final String townId;
  const TownSectionsScreen({super.key, required this.townId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: GlobalKey<ScaffoldState>(),
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: _MainView(townId: townId),
      bottomNavigationBar: const SectionsBottomNavBar(),
    );
  }
}

class _MainView extends ConsumerWidget {
  final String townId;

  const _MainView({required this.townId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      controller: ref.watch(sectionsPageControllerProvider),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: TownSectionsInfo.sections.length,
      itemBuilder: (context, index) {
        return Text(TownSectionsInfo.sections[index].name);
      },      
      onPageChanged: (index) {
        ref.read(selectedSectionIndexProvider.notifier).state =index;
      },
    );
  }
}


