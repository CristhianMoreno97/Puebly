import 'package:puebly/features/towns/domain/entities/town_section.dart';

class Town {
  final int id;
  final String name;
  final String description;
  final String featuredImgUrl;
  final int categoryId;
  final bool enabled;
  final List<TownSection> sections;

  Town({
    required this.id,
    required this.name,
    required this.description,
    required this.featuredImgUrl,
    required this.categoryId,
    required this.enabled,
    this.sections = const [],
  });

  Town copyWith({
    int? id,
    String? name,
    String? description,
    String? featuredImgUrl,
    int? categoryId,
    bool? enabled,
    List<TownSection>? sections,
  }) {
    return Town(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      featuredImgUrl: featuredImgUrl ?? this.featuredImgUrl,
      categoryId: categoryId ?? this.categoryId,
      enabled: enabled ?? this.enabled,
      sections: sections ?? this.sections,
    );
  }  
}
