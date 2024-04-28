import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/towns/domain/entities/town.dart';
import 'package:puebly/features/towns/domain/repositories/towns_repository.dart';
import 'package:puebly/features/towns/presentation/providers/towns_repository_provider.dart';

final townsProvider = StateNotifierProvider<TownsNotifier, TownsState>((ref) {
  final townsRepository = ref.watch(townsRepositoryProvider);
  return TownsNotifier(townsRepository);
});

class TownsNotifier extends StateNotifier<TownsState> {
  final TownsRepository _townsRepository;

  TownsNotifier(this._townsRepository) : super(TownsState()) {
    getTowns();
  }

  Future getTowns() async {
    if (state.isLoading || state.isLastPage) return;
    state = state.copyWith(isLoading: true);

    final towns = await _townsRepository.getTowns(state.page);

    if (towns.isEmpty) {
      state = state.copyWith(isLastPage: true, isLoading: false);
      return;
    }

    state = state.copyWith(
      isLoading: false,
      page: state.page + 1,
      towns: [...state.towns, ...towns],
    );
  }
}

class TownsState {
  final bool isLoading;
  final bool isLastPage;
  final int page;
  final List<Town> towns;

  TownsState({
    this.isLoading = false,
    this.isLastPage = false,
    this.page = 1,
    this.towns = const [],
  });

  TownsState copyWith({
    bool? isLoading,
    bool? isLastPage,
    int? page,
    List<Town>? towns,
  }) {
    return TownsState(
      isLoading: isLoading ?? this.isLoading,
      isLastPage: isLastPage ?? this.isLastPage,
      page: page ?? this.page,
      towns: towns ?? this.towns,
    );
  }
}
