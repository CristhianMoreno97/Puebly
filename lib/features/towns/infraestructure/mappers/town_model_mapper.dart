import 'package:puebly/features/towns/infraestructure/models/town_model.dart';

class TownModelMapper {
  static TownModel fromJson(Map<String, dynamic> json) => TownModel(
        id: json['id'],
        name: json['name'],
        categoryId: json['category_id'],
        description: json['description'],
        featuredImgUrl: json['featured_img_url'],
      );
}
