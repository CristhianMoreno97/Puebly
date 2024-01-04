class TownModel {
  final int id;
  final String name;
  final String description;
  final String featuredImgUrl;
  final int categoryId;

  TownModel({
    required this.id,
    required this.name,
    required this.description,
    required this.featuredImgUrl,
    required this.categoryId,
  });

  TownModel copyWith({
    int? id,
    String? name,
    String? description,
    String? featuredImgUrl,
    int? categoryId,
  }) {
    return TownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}
