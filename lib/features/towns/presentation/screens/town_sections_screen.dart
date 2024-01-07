import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/features/home/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/post_card.dart';
import 'package:puebly/features/towns/presentation/widgets/sections_bottom_navbar.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSectionsScreen extends StatelessWidget {
  final String townId;
  const TownSectionsScreen({super.key, required this.townId});

  @override
  Widget build(BuildContext context) {
    final townCategoryId = int.parse(townId);
    return Scaffold(
      backgroundColor: Colors.white,
      key: GlobalKey<ScaffoldState>(),
      drawer: const CustomDrawer(),
      appBar: const CustomAppBar(),
      body: _MainView(townCategoryId: townCategoryId),
      bottomNavigationBar: const SectionsBottomNavBar(),
    );
  }
}

class _MainView extends ConsumerWidget {
  final int townCategoryId;

  const _MainView({required this.townCategoryId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      controller: ref.watch(sectionsPageControllerProvider),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: TownSectionsInfo.sections.length,
      itemBuilder: (context, index) {
        return _SectionContent(townCategoryId, index);
      },
      onPageChanged: (index) {
        ref.read(selectedSectionIndexProvider.notifier).state = index;
      },
    );
  }
}

class _SectionContent extends ConsumerWidget {
  final int townCategoryId;
  final int pageIndex;
  const _SectionContent(this.townCategoryId, this.pageIndex);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(townProvider(townCategoryId));
    final sectionPosts = posts.townSections[pageIndex].posts;
    return MasonryGridView.count(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        mainAxisSpacing: 16,
        crossAxisCount: 1,
        itemCount: sectionPosts.length,
        itemBuilder: (context, index) {
          return PostCard(post: sectionPosts[index]);
        });
  }
}
