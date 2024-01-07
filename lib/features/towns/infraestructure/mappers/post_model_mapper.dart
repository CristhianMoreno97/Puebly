import 'package:puebly/features/towns/infraestructure/models/post_model.dart';

class PostModelMapper {
  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        featuredImgUrl: json['featured_img_url'],
        sectionCategoryId: json['section_category_id'],
        categories: (json['categories'] as List?)?.cast<Map<String, dynamic>>() ?? [],
        images: (json['images'] as List?)?.cast<String>() ?? [],
      );
}
