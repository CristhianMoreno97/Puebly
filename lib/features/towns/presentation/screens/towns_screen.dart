import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/towns_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/town_card.dart';
import 'package:puebly/features/towns/presentation/widgets/welcome_section.dart';

class TownsScreen extends StatelessWidget {
  const TownsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _CustomAppBar(),
      body: _MainView(),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const _AppBarTitle(),
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorManager.pueblyPrimary1,
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

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: WelcomeSection()),
            SliverToBoxAdapter(child: _HeaderSection()),
            _TownsSection(),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  const _HeaderSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Pueblos",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.pueblyPrimary2a,
                ),
          ),
          Text(
            "Próximamente tú municipio en Puebly.",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: ColorManager.pueblyPrimary2a,
                ),
          ),
        ],
      ),
    );
  }
}

class _TownsSection extends ConsumerWidget {
  const _TownsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = ref.watch(townsProvider).towns;
    return SliverMasonryGrid.extent(
      //crossAxisCount: 2,
      maxCrossAxisExtent: 300,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childCount: towns.length,
      itemBuilder: (context, index) {
        final town = towns[index];
        return TownCard(town: town);
      },
    );
  }
}
