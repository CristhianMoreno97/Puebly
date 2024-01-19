class CategoryModel {
  final int id;
  final String name;
  final String description;
  final int parentId;
  final int count;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.parentId,
    required this.count,
  });
}
