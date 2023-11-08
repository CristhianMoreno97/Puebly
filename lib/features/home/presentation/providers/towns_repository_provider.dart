import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/data/datasources/towns_data_source_impl.dart';
import 'package:puebly/features/home/data/repositories/towns_repository.dart';
import 'package:puebly/features/home/data/repositories/towns_repository_impl.dart';

final townsRepositoryProvider = Provider<TownsRepository>((ref) {
  final townsRepository = TownsRepositoryImpl(TownsDataSourceImpl());
  return townsRepository;
});
