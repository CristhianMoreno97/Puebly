import 'package:puebly/features/home/data/models/town_model.dart';

abstract class TownsDataSource {
  Future<List<TownModel>> getTowns();
}
