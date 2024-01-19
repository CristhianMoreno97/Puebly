import 'package:puebly/features/towns/domain/entities/category.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSection {
  final SectionInfo info;
  final List<Post> posts;
  final List<Category> childCategories;

  TownSection({
    required this.info,
    this.posts = const [],
    this.childCategories = const [],
  });

  TownSection copyWith({
    SectionInfo? info,
    List<Post>? posts,
    List<Category>? childCategories,
  }) {
    return TownSection(
      info: info ?? this.info,
      posts: posts ?? this.posts,
      childCategories: childCategories ?? this.childCategories,
    );
  }
}
