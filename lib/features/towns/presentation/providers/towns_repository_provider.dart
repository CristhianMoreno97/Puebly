import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/towns/domain/repositories/towns_repository.dart';
import 'package:puebly/features/towns/infraestructure/datasources/towns_datasource_impl.dart';
import 'package:puebly/features/towns/infraestructure/repositories/towns_repository_impl.dart';

final townsRepositoryProvider = Provider<TownsRepository>((ref) {
  final townsRepository = TownsRepositoryImpl(TownsDataSourceImpl());
  return townsRepository;
});
