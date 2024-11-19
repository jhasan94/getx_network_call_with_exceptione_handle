import 'dart:developer';
import 'package:get/get.dart';
import 'package:getx_rest_api_call/features/home/model/governorate_response.dart';
import 'package:getx_rest_api_call/features/home/repository/home_repository.dart';

class HomeController extends GetxController {
  final HomeRepository repository;
  HomeController({required this.repository});

  List<Governorate> governorates = [];
  Rx isLoading = Rx(true);

  @override
  void onInit() async {
    await _getGovernorates();
    isLoading.value = false;
    super.onInit();
  }

  _getGovernorates() async {
    var params = <String, dynamic>{};
    params['countryCode'] = 'kw';
    params['lang'] = 'en';
    var result = await repository.getGovernorates(params: params);
    result.fold((failure) => log(failure.message),
        (success) => governorates = success.data.governorates);
  }
}
