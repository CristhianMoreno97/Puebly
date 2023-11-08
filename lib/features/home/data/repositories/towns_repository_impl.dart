import 'package:puebly/features/home/data/datasources/towns_data_source.dart';
import 'package:puebly/features/home/data/models/town_model.dart';
import 'package:puebly/features/home/data/repositories/towns_repository.dart';

class TownsRepositoryImpl extends TownsRepository {
  final TownsDataSource townDataSource;

  TownsRepositoryImpl(this.townDataSource);

  @override
  Future<List<TownModel>> getTowns() {
    return townDataSource.getTowns();
  }
}
