import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/domain/entities/town.dart';
import 'package:puebly/features/towns/presentation/providers/towns_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/widgets/town_card.dart';
import 'package:puebly/features/towns/presentation/widgets/welcome_view.dart';

class TownsScreen extends StatelessWidget {
  const TownsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      drawer: CustomDrawer(),
      appBar: CustomAppBar(),
      body: _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  const _MainView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: const CustomScrollView(
            physics: BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            slivers: [
              SliverToBoxAdapter(child: WelcomeView()),
              SliverToBoxAdapter(child: _HeaderView()),
              _TownsView(),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              SliverToBoxAdapter(child: _FooterView()),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView();

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

class _TownsView extends ConsumerWidget {
  const _TownsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final townsState = ref.watch(townsProvider);
    final towns = townsState.isLoading
        ? List.generate(2, (index) => Town.empty())
        : townsState.towns;
    return SliverMasonryGrid.extent(
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

class _FooterView extends StatelessWidget {
  const _FooterView();

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
