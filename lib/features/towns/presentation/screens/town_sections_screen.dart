import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/features/home/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/post_card.dart';
import 'package:puebly/features/towns/presentation/widgets/section_card.dart';
import 'package:puebly/features/towns/presentation/widgets/sections_bottom_navbar.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSectionsScreen extends ConsumerWidget {
  final String townId;

  const TownSectionsScreen({super.key, required this.townId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final townCategoryId = int.parse(townId);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          drawer: const CustomDrawer(),
          appBar: const CustomAppBar(),
          body: _MainView(townCategoryId: townCategoryId),
          bottomNavigationBar: const SectionsBottomNavBar(),
        ),
        const _SectionsView(),
      ],
    );
  }
}

class _SectionsView extends ConsumerWidget {
  const _SectionsView();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSectionsView = ref.watch(showTownSectionsViewProvider);

    return showSectionsView
        ? Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(showMenu: false),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                  SliverMasonryGrid.extent(
                    maxCrossAxisExtent: 600,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childCount: TownSectionsInfo.sections.length,
                    itemBuilder: (context, index) {
                      return SectionCard(
                        TownSectionsInfo.sections[index],
                        index: index,
                      );
                    },
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 16)),
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}

class _MainView extends ConsumerWidget {
  final int townCategoryId;

  const _MainView({required this.townCategoryId});

  Future<bool> willPopAction(WidgetRef ref) async {
    final showSectionsView = ref.watch(showTownSectionsViewProvider);
    if (!showSectionsView) {
      ref.read(showTownSectionsViewProvider.notifier).state = true;
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async {
        return await willPopAction(ref);
      },
      child: PageView.builder(
        controller: ref.watch(sectionsPageControllerProvider),
        physics: const NeverScrollableScrollPhysics(),
        itemCount: TownSectionsInfo.sections.length,
        itemBuilder: (context, index) {
          return _SectionContent(townCategoryId, index);
        },
        onPageChanged: (index) {
          ref.read(selectedSectionIndexProvider.notifier).state = index;
        },
      ),
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
