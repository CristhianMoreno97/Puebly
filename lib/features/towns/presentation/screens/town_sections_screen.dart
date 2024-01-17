import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/sections_providers.dart';
import 'package:puebly/features/towns/presentation/providers/town_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_drawer.dart';
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
            return _SectionContent(townCategoryId, index);
          },
          onPageChanged: (index) {
            ref.read(sectionIndexProvider.notifier).state = index;
          },
        ),
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
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: _SectionHeader()),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverMasonryGrid.extent(
                //physics: const BouncingScrollPhysics(
                //    decelerationRate: ScrollDecelerationRate.fast),
                maxCrossAxisExtent: 680,

                //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childCount: sectionPosts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: sectionPosts[index]);
                },
              ),
            )
          ],
        ),
        if (posts.isLoading) const _LoadingProgress(),
      ],
    );
  }
}

class User {
  final String? name;
  final String? avatar;
  User({this.name, this.avatar});
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader();

  @override
  Widget build(BuildContext context) {
    List<User> userList = [
      User(name: "Abigail", avatar: "user.png"),
      User(name: "Audrey", avatar: "user.png"),
      User(name: "Ava", avatar: "user.png"),
      User(name: "Bella", avatar: "user.png"),
      User(name: "Bernadette", avatar: "user.png"),
      User(name: "Carol", avatar: "user.png"),
      User(name: "Claire", avatar: "user.png"),
      User(name: "Deirdre", avatar: "user.png"),
      User(name: "Donna", avatar: "user.png"),
      User(name: "Dorothy", avatar: "user.png"),
      User(name: "Faith", avatar: "user.png"),
      User(name: "Gabrielle", avatar: "user.png"),
      User(name: "Grace", avatar: "user.png"),
      User(name: "Hannah", avatar: "user.png"),
      User(name: "Heather", avatar: "user.png"),
      User(name: "Irene", avatar: "user.png"),
      User(name: "Jan", avatar: "user.png"),
      User(name: "Jane", avatar: "user.png"),
      User(name: "Julia", avatar: "user.png"),
      User(name: "Kylie", avatar: "user.png"),
      User(name: "Lauren", avatar: "user.png"),
      User(name: "Leah", avatar: "user.png"),
      User(name: "Lisa", avatar: "user.png"),
      User(name: "Melanie", avatar: "user.png"),
      User(name: "Natalie", avatar: "user.png"),
      User(name: "Olivia", avatar: "user.png"),
      User(name: "Penelope", avatar: "user.png"),
      User(name: "Rachel", avatar: "user.png"),
      User(name: "Ruth", avatar: "user.png"),
      User(name: "Sally", avatar: "user.png"),
      User(name: "Samantha", avatar: "user.png"),
      User(name: "Sarah", avatar: "user.png"),
      User(name: "Theresa", avatar: "user.png"),
      User(name: "Una", avatar: "user.png"),
      User(name: "Vanessa", avatar: "user.png"),
      User(name: "Victoria", avatar: "user.png"),
      User(name: "Wanda", avatar: "user.png"),
      User(name: "Wendy", avatar: "user.png"),
      User(name: "Yvonne", avatar: "user.png"),
      User(name: "Zoe", avatar: "user.png"),
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ExpansionTile(
        backgroundColor: ColorManager.magentaTint2,
        collapsedBackgroundColor: Colors.white,
        leading: const Icon(Icons.filter_list_alt, color: ColorManager.magenta),
        iconColor: ColorManager.magenta,
        collapsedIconColor: ColorManager.magenta,
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        title: Text(
          'Filtrar comercios',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: ColorManager.magentaTint1,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        collapsedShape: RoundedRectangleBorder(
          side: const BorderSide(
            color: ColorManager.magentaTint1,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        children: [
          SizedBox(
            height: 200,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: FilterListWidget(
                listData: userList,
                validateSelectedItem: (list, item) {
                  if (list == null || list.isEmpty) return false;
                  return list.contains(item);
                },
                choiceChipLabel: (item) {
                  return item!.name;
                },
                onItemSearch: (item, query) {
                  return item.name!.toLowerCase().contains(query.toLowerCase());
                },
                applyButtonText: "Aceptar",
                hideSearchField: true,
                hideHeader: true,
                choiceChipBuilder: (context, item, isSelected) {
                  return !(isSelected ?? false)
                      ? Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorManager.magentaTint1),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Text(item.name!),
                        )
                      : Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ColorManager.magentaTint1),
                            borderRadius: BorderRadius.circular(8),
                            color: ColorManager.magentaTint2,
                          ),
                          child: Text(item.name!,
                              style: const TextStyle(color: Colors.black)),
                        );
                },
                controlButtons: const [
                  ControlButtonType.All,
                  ControlButtonType.Reset,
                ],
                allButtonText: "Todos",
                resetButtonText: "Reiniciar",
                onApplyButtonClick: (list) {
                  //Navigator.pop(context);
                },
                backgroundColor: Colors.green,
                headlineText: "Filtrar por usuarios",
                hideSelectedTextCount: true,
                themeData: FilterListThemeData.raw(
                  choiceChipTheme: const ChoiceChipThemeData(),
                  headerTheme:
                      const HeaderThemeData(backgroundColor: Colors.white),
                  controlBarButtonTheme: ControlButtonBarThemeData.raw(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    backgroundColor: Colors.white,
                    controlButtonTheme: ControlButtonThemeData(
                      borderRadius: 8,
                      backgroundColor: Colors.white,
                      primaryButtonBackgroundColor: ColorManager.magenta,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    height: 56,
                    controlContainerDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: ColorManager.magentaTint1,
                        width: 1,
                      ),
                    ),
                  ),
                  borderRadius: 0,
                  wrapAlignment: WrapAlignment.start,
                  wrapCrossAxisAlignment: WrapCrossAlignment.end,
                  wrapSpacing: 0,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingProgress extends StatelessWidget {
  const _LoadingProgress();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const LinearProgressIndicator(
          color: ColorManager.colorSeed,
          backgroundColor: Colors.white,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset('assets/images/puebly-loader.gif', height: 200),
          ),
        ),
      ],
    );
  }
}
