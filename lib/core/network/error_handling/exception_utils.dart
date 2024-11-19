import 'package:getx_rest_api_call/core/app_constant/app_status_code.dart';
import 'package:getx_rest_api_call/core/network/error_handling/exceptions.dart';
import 'package:getx_rest_api_call/core/network/error_handling/failures.dart';

class ExceptionUtils {
  static Object rethrowException(Object e) {
    if ((e is ServerException) ||
        (e is DataParsingException) ||
        (e is ClientSideException) ||
        (e is UnAuthorizedException) ||
        (e is BadRequestException) ||
        (e is NoConnectionException)) {
      throw e;
    } else {
      throw UnknownException();
    }
  }

  static Exception getExceptionFromStatusCode(int statusCode) {
    if (statusCode == AppStatusCode.unAuthorized) {
      return UnAuthorizedException();
    } else if (statusCode == AppStatusCode.severError) {
      return ServerException();
    } else {
      return UnknownException();
    }
  }

  static FailureEntity convertExceptionToFailure(Object e) {
    if (e is ServerException) {
      return const ServerFailure();
    } else if (e is DataParsingException) {
      return const DataParsingFailure();
    } else if (e is NoConnectionException) {
      return const NoConnectionFailure();
    } else if (e is ClientSideException) {
      return const ClientFailure();
    } else if (e is BadRequestException) {
      return BadRequestFailure(e.message);
    } else {
      return const UnknownFailure();
    }
  }
}
