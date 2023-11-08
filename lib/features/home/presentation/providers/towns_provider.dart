import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/data/models/town_model.dart';
import 'package:puebly/features/home/data/repositories/towns_repository.dart';
import 'package:puebly/features/home/presentation/providers/towns_repository_provider.dart';

final townsProvider = StateNotifierProvider<TownsNotifier, TownsState>((ref) {
  final townsRepository = ref.watch(townsRepositoryProvider);
  return TownsNotifier(townsRepository);
});

class TownsNotifier extends StateNotifier<TownsState> {
  final TownsRepository _townsRepository;

  TownsNotifier(this._townsRepository) : super(TownsState()) {
    getTowns();
  }

  Future<void> getTowns() async {
    state = TownsState(isLoading: true);
    try {
      final towns = await _townsRepository.getTowns();
      state = state.copyWith(towns: towns);
    } catch (e) {
      state = TownsState(isFailed: true, errorMessage: e.toString());
    }
  }
}

class TownsState {
  final bool isLoading;
  final bool isFailed;
  final List<TownModel> towns;
  final String errorMessage;

  TownsState({
    this.isLoading = true,
    this.isFailed = false,
    this.towns = const [],
    this.errorMessage = '',
  });

  TownsState copyWith({
    bool? isLoading,
    bool? isFailed,
    List<TownModel>? towns,
    String? errorMessage,
  }) {
    return TownsState(
      isLoading: isLoading ?? this.isLoading,
      isFailed: isFailed ?? this.isFailed,
      towns: towns ?? this.towns,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
