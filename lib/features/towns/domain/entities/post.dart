class Post {
  final int id;
  final String title;
  final String content;
  final String featuredImgUrl;
  final List<String> images;
  final List<Map<String, dynamic>> categories;
  final Map<String, String> contactInfo;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.featuredImgUrl,
    required this.images,
    required this.categories,
    required this.contactInfo,
  });

  Post copyWith({
    int? id,
    String? title,
    String? content,
    String? featuredImgUrl,
    List<String>? images,
    List<Map<String, dynamic>>? categories,
    Map<String, String>? contactInfo,
  }) {
    return Post(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      images: images ?? this.images,
      categories: categories ?? this.categories,
      contactInfo: contactInfo ?? this.contactInfo,
    );
  }
}
