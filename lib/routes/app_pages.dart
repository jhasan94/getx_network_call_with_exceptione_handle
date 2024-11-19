import 'package:getx_rest_api_call/features/home/bindings/home_binding.dart';
import 'package:getx_rest_api_call/features/home/presentation/home_page.dart';
import 'package:getx_rest_api_call/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBindings(),
      transition: Transition.native,
    ),
  ];
}