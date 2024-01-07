class TownModel {
  final int id;
  final String name;
  final String description;
  final String featuredImgUrl;
  final int categoryId;
  final bool enabled;

  TownModel({
    required this.id,
    required this.name,
    required this.description,
    required this.featuredImgUrl,
    required this.categoryId,
    required this.enabled,
  });

  TownModel copyWith({
    int? id,
    String? name,
    String? description,
    String? featuredImgUrl,
    int? categoryId,
    bool? enabled,
  }) {
    return TownModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      categoryId: categoryId ?? this.categoryId,
      enabled: enabled ?? this.enabled,
    );
  }
}
