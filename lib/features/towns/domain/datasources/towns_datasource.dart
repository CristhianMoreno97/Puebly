import 'package:puebly/features/towns/infraestructure/models/category_model.dart';
import 'package:puebly/features/towns/infraestructure/models/post_model.dart';
import 'package:puebly/features/towns/infraestructure/models/town_model.dart';

abstract class TownsDataSource {
  Future<List<TownModel>> getTowns(int page);
  Future<List<PostModel>> getNewerPosts(int townCategoryId, int page,
      {int? section, List<int>? sectionChilds});
  Future<List<CategoryModel>> getSectionChildCategories(int townCategoryId);
}