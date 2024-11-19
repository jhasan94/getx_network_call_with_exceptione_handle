import 'package:get/get.dart';
import 'package:getx_rest_api_call/core/network/api_client/api_client.dart';
import 'package:getx_rest_api_call/features/home/controller/home_controller.dart';
import 'package:getx_rest_api_call/features/home/data/home_data_source.dart';
import 'package:getx_rest_api_call/features/home/repository/home_repository.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiClient());
    Get.lazyPut(() => HomeDataSource(apiClient: Get.find()));
    Get.lazyPut(() => HomeRepository(dataSource: Get.find()));
    Get.lazyPut(() => HomeController(repository: Get.find()));
  }
}
