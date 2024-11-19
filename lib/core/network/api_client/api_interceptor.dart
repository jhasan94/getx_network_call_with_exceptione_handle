import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:getx_rest_api_call/core/network/auth_credential.dart';

class ApiInterceptor {

  static Request<dynamic> addRequestInterceptor(Request request) {
    String basicAuth = 'Basic ${base64.encode(utf8.encode('${AuthCredential.username}:${AuthCredential.password}'))}';
    request.headers['authorization'] = basicAuth;
    request.headers['content-type'] = 'application/json';
    log("Request: ${request.method} ${request.url}");
    return request;
  }

  static Future<Response<dynamic>> addResponseInterceptor(
      Request<dynamic> request, Response<dynamic> response) async {
    log("======status code======: ${response.statusCode}");
    log("======api response======: ${response.body}");
    if (response.statusCode != 200) log("====Error:===== ${response.body}");
    return response;
  }
}
