import 'package:dartz/dartz.dart';
import 'package:getx_rest_api_call/core/app_constant/api_end_points.dart';
import 'package:getx_rest_api_call/core/network/api_client/api_client.dart';
import 'package:getx_rest_api_call/core/network/error_handling/error_object.dart';
import 'package:getx_rest_api_call/features/home/model/governorate_response.dart';

class HomeDataSource {
  final ApiClient apiClient;

  HomeDataSource({required this.apiClient});

  Future<Either<ErrorObject, GovernorateResponse>> getGovernorates(Map<String, dynamic> params) async {
    final response = await apiClient.handleRequest<GovernorateResponse>(
      endPoint: ApiEndPoints.governorate,
      queryParams: params,
      fromJson: GovernorateResponse.fromRawJson,
      method: RequestType.get,
    );
    return response;
  }
}
