import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/providers/towns_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/town_card.dart';
import 'package:puebly/features/towns/presentation/widgets/welcome_section.dart';

class TownsScreen extends StatelessWidget {
  const TownsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: GlobalKey<ScaffoldState>(),
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: const _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: WelcomeSection()),
            SliverToBoxAdapter(child: _HeaderSection()),
            _TownsSection(),
            SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverToBoxAdapter(child: _FooterSection()),
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
          const SizedBox(height: 8),
          Text(
            "Recorre los pueblos mágicos de Boyacá",
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: ColorManager.pueblySecundary1,
                ),
          ),
          const SizedBox(height: 8),
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
      mainAxisSpacing: 16,
      crossAxisSpacing: 8,
      childCount: towns.length,
      itemBuilder: (context, index) {
        final town = towns[index];
        return TownCard(town: town);
      },
    );
  }
}

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Text(
      "¡Próximamente tú municipio en Puebly!",
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: Colors.black54,
          ),
    );
  }
}
