import 'package:dio/dio.dart';
import 'package:puebly/features/home/data/datasources/towns_data_source.dart';
import 'package:puebly/features/home/data/models/town_model.dart';

class TownsDataSourceImpl extends TownsDataSource {
  late final Dio _dio;
  
  TownsDataSourceImpl() {
    _dio = Dio();
    _dio.options.baseUrl = 'https://puebly.com';
  }

  @override
  Future<List<TownModel>> getTowns() async {
    try {
      final response = await _dio.get('/wp-json/api/v1/towns');
      final List<TownModel> towns = (response.data as List)
          .map((town) => TownModel.fromJson(town))
          .toList();
      return towns;
    } catch (e) {
      rethrow;
    }

  }
}
