import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSection {
  final SectionInfo info;
  final List<Post> posts;

  TownSection({
    required this.info,
    this.posts = const [],
  });

  TownSection copyWith({
    SectionInfo? info,
    List<Post>? posts,
  }) {
    return TownSection(
      info: info ?? this.info,
      posts: posts ?? this.posts,
    );
  }
}
