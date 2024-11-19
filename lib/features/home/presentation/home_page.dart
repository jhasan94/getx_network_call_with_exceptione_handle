import 'package:flutter/material.dart';
import 'package:getx_rest_api_call/features/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Governorate List"),
      ),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(itemBuilder: (BuildContext context, int index) {
                var data = controller.governorates[index];
                return Card(
                  child: Column(
                    children: [
                      Text(data.name).paddingAll(4),
                      Text(data.latlng).paddingAll(4),
                    ],
                  ).paddingAll(8),
                );
              });
      }),
    );
  }
}
