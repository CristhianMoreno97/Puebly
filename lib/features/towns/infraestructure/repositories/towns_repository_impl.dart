import 'package:puebly/features/towns/domain/datasources/towns_datasource.dart';
import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/domain/entities/town.dart';
import 'package:puebly/features/towns/domain/repositories/towns_repository.dart';

class TownsRepositoryImpl extends TownsRepository {
  final TownsDataSource _townsDataSource;

  TownsRepositoryImpl(this._townsDataSource);

  @override
  Future<List<Town>> getTowns(int page) async {
    final townsModel = await _townsDataSource.getTowns(page);
    return townsModel
        .map((town) => Town(
            id: town.id,
            name: town.name,
            description: town.description,
            featuredImgUrl: town.featuredImgUrl,
            enabled: town.enabled,
            categoryId: town.categoryId))
        .toList();
  }

  @override
  Future<Map<int, List<Post>>> getNewerPosts(int townCategoryId, int page) async {
    try {
      final postModels = await _townsDataSource.getNewerPosts(townCategoryId, page);
      final newerPostByCategory = <int, List<Post>>{};
      for (final postModel in postModels) {
        final categoryId = postModel.sectionCategoryId;
        newerPostByCategory[categoryId] ??= [];
        newerPostByCategory[categoryId]!.add(Post(
            id: postModel.id,
            title: postModel.title,
            content: postModel.content,
            featuredImgUrl: postModel.featuredImgUrl,
            images: postModel.images,
            categories: postModel.categories));
      }
      return newerPostByCategory;
    } catch (e) {
      rethrow;
    }
  }
}
