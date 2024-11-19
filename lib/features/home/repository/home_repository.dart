import 'package:dartz/dartz.dart';
import 'package:getx_rest_api_call/features/home/data/home_data_source.dart';
import 'package:getx_rest_api_call/core/network/error_handling/error_object.dart';
import 'package:getx_rest_api_call/features/home/model/governorate_response.dart';

class HomeRepository {
  final HomeDataSource dataSource;
  HomeRepository({required this.dataSource});

  Future<Either<ErrorObject, GovernorateResponse>> getGovernorates(
      {required Map<String, dynamic> params}) async {
    return await dataSource.getGovernorates(params);
  }
}
