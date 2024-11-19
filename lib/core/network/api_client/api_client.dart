import 'dart:io';
import 'dart:async';
import 'api_interceptor.dart';
import 'package:dartz/dartz.dart';
import 'package:retry/retry.dart';
import 'package:get/get_connect/connect.dart';
import 'package:getx_rest_api_call/core/network/auth_credential.dart';
import 'package:getx_rest_api_call/core/app_constant/api_end_points.dart';
import 'package:getx_rest_api_call/core/app_constant/app_status_code.dart';
import 'package:getx_rest_api_call/core/network/error_handling/bad_request.dart';
import 'package:getx_rest_api_call/core/network/error_handling/exception_utils.dart';
import 'package:getx_rest_api_call/core/network/error_handling/exceptions.dart';
import 'package:getx_rest_api_call/core/network/error_handling/error_object.dart';


class ApiClient extends GetConnect {
  ApiClient() {
    httpClient.addRequestModifier(ApiInterceptor.addRequestInterceptor);
    httpClient.addResponseModifier(ApiInterceptor.addResponseInterceptor);
  }

  Future<Either<ErrorObject, T>> handleRequest<T>({
    required String endPoint,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    required T Function(String) fromJson,
    required RequestType method,
  }) async {
    try {
      String api = AuthCredential.baseUrl + endPoint;
      Response response;
      if (method == RequestType.get) {
        response = await _getRequest(endPoint: api, queryParams: queryParams);
      } else if (method == RequestType.post) {
        response = await _postRequest(endPoint: api, body: body!);
      } else {
        throw Exception("Unsupported Request Type");
      }
      return Right(await _handleResponse(response, fromJson));
    } catch (e) {
      return left(ErrorObject.mapFailureToErrorObject(
          failure: ExceptionUtils.convertExceptionToFailure(e)));
    }
  }

  Future<T> _handleResponse<T>(
      Response response, T Function(String) fromJson) async {
    if (response.statusCode == AppStatusCode.success) {
      try {
        return fromJson(response.body);
      } catch (e) {
        throw DataParsingException();
      }
    } else if (response.statusCode == AppStatusCode.badRequest) {
      BadRequest errorResponse = BadRequest.fromJson(response.body);
      throw BadRequestException(message: errorResponse.message);
    } else {
      throw ExceptionUtils.getExceptionFromStatusCode(
          response.statusCode ?? AppStatusCode.notFound);
    }
  }

  Future<Response> _getRequest({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    return await retry(
      () async => get(endPoint, query: queryParams),
      retryIf: (e) async => e is SocketException || e is TimeoutException,
    );
  }

  Future<Response> _postRequest({
    required String endPoint,
    required Map body,
    Map<String, dynamic>? queryParams,
  }) async {
    return await retry(
      () async => post(endPoint, body, query: queryParams),
      retryIf: (e) async => e is SocketException || e is TimeoutException,
    );
  }
}
