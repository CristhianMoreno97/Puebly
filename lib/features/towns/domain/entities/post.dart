class Post {
  final int id;
  final String title;
  final String content;
  final String featuredImgUrl;
  final List<String> images;
  final List<Map<String, dynamic>> categories;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.featuredImgUrl,
    required this.images,
    required this.categories,
  });

  Post copyWith({
    int? id,
    String? title,
    String? content,
    String? featuredImgUrl,
    List<String>? images,
    List<Map<String, dynamic>>? categories,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      images: images ?? this.images,
      categories: categories ?? this.categories,
    );
  }
}
