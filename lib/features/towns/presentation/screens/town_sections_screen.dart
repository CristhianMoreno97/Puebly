import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_accordion.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_filter_wrap.dart';
import 'package:puebly/features/towns/presentation/widgets/post_card.dart';
import 'package:puebly/features/towns/presentation/widgets/section_card.dart';
import 'package:puebly/features/towns/presentation/widgets/sections_bottom_navbar.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';
import 'package:url_launcher/url_launcher.dart';

class TownSectionsScreen extends ConsumerWidget {
  final String townId;

  const TownSectionsScreen({super.key, required this.townId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final townCategoryId = int.parse(townId);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: ColorManager.greyCultured,
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
                    SliverToBoxAdapter(
                      child: Text(
                        'Puebly realiza un proceso de verificación para asegurar la autenticidad de las publicaciones antes de que puedan visualizarse en nuestra aplicación. Sin embargo, te recomendamos siempre realizar tus propias verificaciones adicionales antes de llevar a cabo cualquier transacción.',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: Colors.black54,
                            ),
                      ),
                    ),
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 16),
                    ),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) {
        if (didPop) return;

        final showSectionsView = ref.read(showTownSectionsViewProvider);
        if (!showSectionsView) {
          ref.read(showTownSectionsViewProvider.notifier).state = true;
          return;
        }

        final NavigatorState navigator = Navigator.of(context);
        navigator.pop();
      },
      child: SafeArea(
        child: PageView.builder(
          controller: ref.watch(sectionsPageControllerProvider),
          physics: const NeverScrollableScrollPhysics(),
          itemCount: TownSectionsInfo.sections.length,
          itemBuilder: (context, index) {
            return _SectionView(
              key: PageStorageKey('pageKey$index'),
              townCategoryId: townCategoryId,
              pageIndex: index,
            );
          },
          onPageChanged: (index) async {
            final previousIndex = ref.read(sectionIndexProvider);
            _resetAndFetchSection(ref, {}, previousIndex);
            ref.read(sectionIndexProvider.notifier).state = index;
          },
        ),
      ),
    );
  }

  Future<void> _resetAndFetchSection(
      WidgetRef ref, Set<int> currentSet, int sectionIndex) async {
    final selectedFilters =
        ref.read(selectedFiltersProvider)[sectionIndex] ?? {};
    final isLoading = ref
        .read(townProvider(townCategoryId))
        .townSections[sectionIndex]
        .isLoading;

    if (selectedFilters.isEmpty || isLoading) return;

    ref.read(townProvider(townCategoryId).notifier).resetSection(sectionIndex);
    ref.read(selectedFiltersProvider.notifier).state[sectionIndex] = currentSet;
    await ref.read(townProvider(townCategoryId).notifier).getSectionPosts(
          sectionIndex,
          childCategories: currentSet.toList(),
        );
  }
}

class _SectionView extends ConsumerStatefulWidget {
  final int townCategoryId;
  final int pageIndex;

  const _SectionView({
    super.key,
    required this.townCategoryId,
    required this.pageIndex,
  });

  @override
  _SectionViewState createState() => _SectionViewState();
}

class _SectionViewState extends ConsumerState<_SectionView> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() async {
      final scrollPosition = scrollController.position;

      if ((scrollPosition.pixels + 600) >= scrollPosition.maxScrollExtent) {
        final townSection = ref
            .read(townProvider(widget.townCategoryId))
            .townSections[widget.pageIndex];

        if (townSection.isLastPage || townSection.isLoading) {
          return;
        }

        final selectedFilters = ref.read(selectedFiltersProvider);
        final List<int> childCategoryIds =
            selectedFilters[widget.pageIndex]?.toList() ?? [];

        await ref
            .read(townProvider(widget.townCategoryId).notifier)
            .getSectionPosts(widget.pageIndex,
                childCategories: childCategoryIds);
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
    return CustomScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: _SectionHeader(widget.townCategoryId, widget.pageIndex),
        ),
        const SliverToBoxAdapter(
          child: _AdText(),
        ),
        SliverToBoxAdapter(
          child: _PostsView(
            townCategoryId: widget.townCategoryId,
            pageIndex: widget.pageIndex,
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(height: 16),
        )
      ],
    );
  }
}

class _AdText extends ConsumerWidget {
  const _AdText();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sectionIndex = ref.watch(sectionIndexProvider);
    final adText = TownSectionsInfo.sections[sectionIndex].adText;
    final adButtonText = TownSectionsInfo.sections[sectionIndex].adButtonText;
    final whatsappUri = Uri.parse(
        'whatsapp://send?phone=${EnviromentConstants.whatsappNumber}');

    return adText != null
        ? Padding(
            padding: const EdgeInsets.only(top: 4, bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(adText, style: Theme.of(context).textTheme.bodySmall),
                if (adButtonText != null)
                  TextButton(
                    onPressed: () async {
                      if (await canLaunchUrl(whatsappUri)) {
                        await launchUrl(whatsappUri,
                            mode: LaunchMode.externalApplication);
                      } else {
                        throw 'Could not launch $whatsappUri';
                      }
                    },
                    style: const ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 4, vertical: 0)),
                        visualDensity: VisualDensity.compact),
                    child: Text(
                      adButtonText,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorManager.malachiteTone3),
                    ),
                  )
              ],
            ),
          )
        : const SizedBox(height: 16);
  }
}

class _PostsView extends ConsumerWidget {
  const _PostsView({
    required this.townCategoryId,
    required this.pageIndex,
  });

  final int townCategoryId;
  final int pageIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final townSection =
        ref.watch(townProvider(townCategoryId)).townSections[pageIndex];

    return Column(
      children: [
        if (townSection.posts.isNotEmpty)
          _PostsViewNonSliver(
            townCategoryId: townCategoryId,
            pageIndex: pageIndex,
          ),
        if (townSection.posts.isNotEmpty) const SizedBox(height: 16),
        if (!townSection.isLastPage)
          const Padding(
              padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: PostCard())
      ],
    );
  }
}

class _PostsViewNonSliver extends ConsumerWidget {
  final int townCategoryId;
  final int pageIndex;

  const _PostsViewNonSliver({
    required this.townCategoryId,
    required this.pageIndex,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(townProvider(townCategoryId));
    final sectionPosts = posts.townSections[pageIndex].posts;

    return MasonryGridView.extent(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      maxCrossAxisExtent: 680,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: sectionPosts.length,
      itemBuilder: (context, index) {
        return PostCard(post: sectionPosts[index]);
      },
    );
  }
}

class _SectionHeader extends ConsumerWidget {
  final int townCategoryId;
  final int pageIndex;

  const _SectionHeader(this.townCategoryId, this.pageIndex);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomAccordion(
      townCategoryId: townCategoryId,
      sectionIndex: pageIndex,
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
