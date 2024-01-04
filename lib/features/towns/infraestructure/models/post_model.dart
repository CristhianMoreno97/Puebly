class PostModel {
  final int id;
  final String title;
  final String content;
  final String featuredImgUrl;
  final List<String> images;
  final Map<String, dynamic> categories;
  final String sectionCategoryId;

  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.featuredImgUrl,
    required this.images,
    required this.categories,
    required this.sectionCategoryId,
  });

  PostModel copyWith({
    int? id,
    String? title,
    String? content,
    String? featuredImgUrl,
    List<String>? images,
    Map<String, dynamic>? categories,
    String? sectionCategoryId,
  }) {
    return PostModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      images: images ?? this.images,
      categories: categories ?? this.categories,
      sectionCategoryId: sectionCategoryId ?? this.sectionCategoryId,
    );
  }
}
