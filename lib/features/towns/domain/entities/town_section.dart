import 'package:puebly/features/towns/domain/entities/category.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSection {
  final SectionInfo info;
  final List<Post> posts;
  final List<Category> childCategories;
  final bool isLoading;
  final bool isLastPage;
  final int page;

  TownSection({
    required this.info,
    this.posts = const [],
    this.childCategories = const [],
    this.isLoading = false,
    this.isLastPage = false,
    this.page = 1,
  });

  TownSection copyWith({
    SectionInfo? info,
    List<Post>? posts,
    List<Category>? childCategories,
    bool? isLoading,
    bool? isLastPage,
    int? page,
  }) {
    return TownSection(
      info: info ?? this.info,
      posts: posts ?? this.posts,
      childCategories: childCategories ?? this.childCategories,
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      page: page ?? this.page,
    );
  }
}
