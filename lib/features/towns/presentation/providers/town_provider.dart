import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/domain/entities/town_section.dart';
import 'package:puebly/features/towns/domain/repositories/towns_repository.dart';
import 'package:puebly/features/towns/presentation/providers/towns_repository_provider.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

final townProvider = StateNotifierProvider.family<TownNotifier, TownState, int>(
    (ref, townCategoryId) {
  final townsRepository = ref.watch(townsRepositoryProvider);
  return TownNotifier(townsRepository, townCategoryId: townCategoryId);
});

class TownNotifier extends StateNotifier<TownState> {
  final TownsRepository _townsRepository;
  final int townCategoryId;

  TownNotifier(this._townsRepository, {required this.townCategoryId})
      : super(TownState(
          townSections: TownSectionsInfo.sections
              .map((section) => TownSection(info: section))
              .toList(),
          page: TownSectionsInfo.sections.map((e) => 1).toList(),
        )) {
    getNewerPosts();
  }

  Future getNewerPosts() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);

    final newerPostByCategory =
        await _townsRepository.getNewerPosts(townCategoryId, 1);

    if (newerPostByCategory.isEmpty) {
      state = state.copyWith(isLastPage: true, isLoading: false);
      return;
    }

    state = state.copyWith(
      isLoading: false,
      page: state.page.map((e) => e + 1).toList(),
      townSections: state.townSections
          .map((section) => section.copyWith(
                posts: [
                  ...section.posts,
                  ...newerPostByCategory[section.info.categoryId] ?? []
                ],
                isLoading: false,
                isLastPage: false,
                page: section.page + 1,
              ))
          .toList(),
    );

    getSectionChildCategories();
  }

  Future getSectionPosts(int sectionIndex, {List<int>? childCategories}) async {
    final targetSection = state.townSections[sectionIndex];

    if (targetSection.isLoading || targetSection.isLoading) return;

    state = state.copyWith(
      townSections: state.townSections.map((section) {
        if (section.info.categoryId == targetSection.info.categoryId) {
          return section.copyWith(isLoading: true);
        }
        return section;
      }).toList(),
    );

    final postsByCategory = await _townsRepository.getNewerPosts(
      townCategoryId,
      targetSection.page,
      section: targetSection.info.categoryId,
      sectionChilds: childCategories,
    );

    if (postsByCategory.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        townSections: state.townSections.map((section) {
          if (section.info.categoryId == targetSection.info.categoryId) {
            return section.copyWith(
              isLastPage: true,
              isLoading: false,
            );
          }
          return section;
        }).toList(),
      );
      return;
    }

    state = state.copyWith(
      isLoading: false,
      townSections: state.townSections.map((section) {
        if (section.info.categoryId == targetSection.info.categoryId) {
          return section.copyWith(
            posts: [
              ...section.posts,
              ...postsByCategory[section.info.categoryId] ?? []
            ],
            isLoading: false,
            isLastPage: false,
            page: section.page + 1,
          );
        }
        return section;
      }).toList(),
    );
  }

  void resetSection(int sectionIndex) {
    final categoryId = state.townSections[sectionIndex].info.categoryId;
    state = state.copyWith(
      townSections: state.townSections.map((section) {
        if (section.info.categoryId == categoryId) {
          return section.copyWith(
            posts: [],
            page: 1,
            isLastPage: false,
            isLoading: false,
          );
        }
        return section;
      }).toList(),
    );
  }

  Future getSectionChildCategories() async {
    if (state.isChildCategoriesLoading) return;

    state = state.copyWith(isChildCategoriesLoading: true);

    final childCategories =
        await _townsRepository.getSectionChildCategories(townCategoryId);

    state = state.copyWith(
      isChildCategoriesLoading: false,
      townSections: state.townSections
          .map((section) => section.copyWith(
                childCategories: childCategories[section.info.categoryId],
              ))
          .toList(),
    );
  }
}

class TownState {
  final bool isLoading;
  final bool isChildCategoriesLoading;
  final bool isLastPage;
  final List<int> page;
  final List<TownSection> townSections;

  TownState({
    this.isLoading = false,
    this.isChildCategoriesLoading = false,
    this.isLastPage = false,
    this.page = const [],
    this.townSections = const [],
  });

  TownState copyWith({
    bool? isLoading,
    bool? isChildCategoriesLoading,
    bool? isLastPage,
    List<int>? page,
    List<TownSection>? townSections,
  }) {
    return TownState(
      isLoading: isLoading ?? this.isLoading,
      isChildCategoriesLoading: isChildCategoriesLoading ?? this.isChildCategoriesLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      page: page ?? this.page,
      townSections: townSections ?? this.townSections,
    );
  }

  List<Post> postsByCategory(int categoryId) {
    return townSections
        .firstWhere((section) => section.info.categoryId == categoryId)
        .posts;
  }
}
