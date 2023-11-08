import 'package:puebly/features/home/data/models/town_model.dart';
import 'package:puebly/features/home/data/repositories/towns_repository.dart';

class GetTownsUseCase {
  final TownsRepository _townRepository;
  GetTownsUseCase(this._townRepository);

  Future<List<TownModel>> execute() {
    return _townRepository.getTowns();
  }
}
