import 'package:puebly/features/towns/infraestructure/models/category_model.dart';

class CategoryModelMapper {
  static CategoryModel fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        parentId: json['parent_id'],
        count: json['count'],
      );
}
