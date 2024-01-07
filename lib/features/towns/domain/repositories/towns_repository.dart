import 'package:puebly/features/towns/domain/entities/post.dart';
import 'package:puebly/features/towns/domain/entities/town.dart';

abstract class TownsRepository {
  Future<List<Town>> getTowns(int page);
  Future<Map<int, List<Post>>> getNewerPosts(int townCategoryId,int page);
}