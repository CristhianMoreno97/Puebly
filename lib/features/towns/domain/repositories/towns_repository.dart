import 'package:puebly/features/towns/domain/entities/town.dart';

abstract class TownsRepository {
  Future<List<Town>> getTowns(int page);
}