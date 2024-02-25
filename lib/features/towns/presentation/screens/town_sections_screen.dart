import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_expansion_tile.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_filter_list.dart';
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
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
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
      child: SafeArea(
        child: PageView.builder(
          controller: ref.watch(sectionsPageControllerProvider),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: TownSectionsInfo.sections.length,
          itemBuilder: (context, index) {
            return _SectionView(townCategoryId, index);
          },
          onPageChanged: (index) {
            ref.read(sectionIndexProvider.notifier).state = index;
          },
        ),
      ),
    );
  }
}

class _SectionView extends ConsumerStatefulWidget {
  final int townCategoryId;
  final int pageIndex;
  const _SectionView(this.townCategoryId, this.pageIndex);

  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends ConsumerState<_SectionView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async {
      if ((scrollController.position.pixels + 600) >= scrollController.position.maxScrollExtent) {
        final selectedFilters = ref.read(selectedFiltersProvider);
        final List<int> childCategoryIds =  selectedFilters.keys.toList();

        await ref
            .read(townProvider(widget.townCategoryId).notifier)
            .getSectionPosts(widget.pageIndex, childCategories: childCategoryIds);
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(townProvider(widget.townCategoryId));
    return Stack(
      children: [
        CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
                child: _SectionHeader(widget.townCategoryId, widget.pageIndex)),
            if (posts.townSections[widget.pageIndex].posts.isNotEmpty)
              _SectionContent(widget.townCategoryId, widget.pageIndex),
            if (!posts.townSections[widget.pageIndex].isLastPage)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                  child: PostCard(),
                ),
              ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
          ],
        ),
        if (posts.isLoading) const _LoadingProgress(),
      ],
    );
  }
}

class _SectionHeader extends ConsumerWidget {
  final int townCategoryId;
  final int pageIndex;
  const _SectionHeader(this.townCategoryId, this.pageIndex);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final childCategories = ref
        .watch(townProvider(townCategoryId))
        .townSections[pageIndex]
        .childCategories;
    final sectionInfo =
        ref.watch(townProvider(townCategoryId)).townSections[pageIndex].info;
    
    return CustomExpansionTile(
      title: sectionInfo.filterTitle,
      filters: childCategories,
      townCategoryId: townCategoryId,
      sectionIndex: pageIndex,
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

    return SliverPadding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
      sliver: SliverMasonryGrid.extent(
        // physics: const BouncingScrollPhysics(
        //     decelerationRate: ScrollDecelerationRate.fast),
        maxCrossAxisExtent: 680,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childCount: sectionPosts.length,
        itemBuilder: (context, index) {
          return PostCard(post: sectionPosts[index]);
        },
      ),
    );
  }
}

class _LoadingProgress extends StatelessWidget {
  const _LoadingProgress();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        LinearProgressIndicator(
          color: ColorManager.colorSeed,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
