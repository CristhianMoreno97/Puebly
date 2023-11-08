import 'package:puebly/features/home/data/models/town_model.dart';

abstract class TownsRepository {
  Future<List<TownModel>> getTowns();
}
