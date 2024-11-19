import 'package:flutter/material.dart';
import 'package:getx_rest_api_call/routes/app_pages.dart';
import 'package:getx_rest_api_call/routes/app_routes.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    enableLog: true,
    debugShowCheckedModeBanner: false,
    initialRoute: AppRoutes.initialRoute,
    getPages: AppPages.routes,
    defaultTransition: Transition.zoom,
  ));
}
