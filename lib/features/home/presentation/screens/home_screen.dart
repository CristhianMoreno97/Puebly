import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/towns_provider.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';
import 'package:puebly/features/home/presentation/widgets/custom_home_card.dart';
import 'package:puebly/features/home/presentation/widgets/custom_town_grid_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: ColorManager.pueblyPrimary1,
        title: const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
          child: AppBarTitle(),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: const SafeArea(
        child: HomeSection(),
      ),
      //bottomNavigationBar: const CustomButtonAppbar(),
    );
  }
}

class HomeSection extends ConsumerWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final townsState = ref.watch(townsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const HomeHeader(),
        Expanded(
            child: townsState.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: ColorManager.pueblyPrimary1,
                  ))
                : const HomeGridButtons()),
      ],
    );
  }
}

class HomeGridButtons extends ConsumerWidget {
  const HomeGridButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final towns = ref.watch(townsProvider).towns;
    return MasonryGridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        itemCount: towns.length,
        itemBuilder: (context, index) {
          final town = towns[index];
          return CustomTownGridCard(
            title: town.name,
            description: town.description,
            imagePath: town.imagePath,
            townId: town.id,
            enabled: town.enabled,
          );
        });
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        HomeHeaderContent(),
      ],
    );
  }
}

class HomeHeaderContent extends StatelessWidget {
  const HomeHeaderContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomHomeCard(),
          SizedBox(height: 16),
          Text(
            "Pueblos",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorManager.pueblyPrimary2a,
            ),
          ),
          Text(
            "Próximamente tú municipio en Puebly.",
            style: TextStyle(
              fontSize: 12,
              //fontWeight: FontWeight.bold,
              color: ColorManager.pueblyPrimary2a,
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
