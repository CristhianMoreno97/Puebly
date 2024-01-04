import 'package:puebly/features/towns/infraestructure/models/town_model.dart';

abstract class TownsDataSource {
  Future<List<TownModel>> getTowns(int page);
}