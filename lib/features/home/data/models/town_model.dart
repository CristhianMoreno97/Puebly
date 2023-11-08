class TownModel {
  final bool enabled;
  final String description;
  final String hexColor;
  final String id;
  final String name;
  final String? imagePath;

  TownModel({
    required this.enabled,
    required this.description,
    required this.hexColor,
    required this.id,
    required this.name,
    this.imagePath,
  });

  factory TownModel.fromJson(Map<String, dynamic> json) {
    return TownModel(
      enabled: json['enabled'],
      description: json['description'],
      hexColor: json['hexColor'],
      id: json['id'],
      name: json['name'],
      imagePath: json['imagePath'],
    );
  }
}
