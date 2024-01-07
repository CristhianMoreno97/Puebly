import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/presentation/widgets/town_sections_info.dart';

class TownSection {
  final SectionInfo info;
  //final String name;
  //final String description;
  //final String featuredImgUrl;
  //final IconData icon;
  //final Color color;
  final List<Post> posts;

  TownSection({
    required this.info,
    //required this.name,
    //required this.description,
    //required this.featuredImgUrl,
    //required this.icon,
    //required this.color,
    this.posts = const [],
  });

  TownSection copyWith({
    SectionInfo? info,
    //String? name,
    //String? description,
    //String? featuredImgUrl,
    //IconData? icon,
    //Color? color,
    List<Post>? posts,
  }) {
    return TownSection(
      info: info ?? this.info,
      //name: name ?? this.name,
      //description: description ?? this.description,
      //featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      //icon: icon ?? this.icon,
      //color: color ?? this.color,
      posts: posts ?? this.posts,
    );
  }
}
