import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/map_page_controller.dart';
import 'package:lordsbox/view/widget/mapPage/counter.dart';
import 'package:lordsbox/view/widget/mapPage/error_layout.dart';
import 'package:lordsbox/view/widget/mapPage/my_map.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MapPageController());

    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Obx(
                () {
                  return controller.posStream.value["latitude"] == null ||
                          controller.posStream.value["longitude"] == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : MyMap();
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.stopTheService();
                },
                child: Text("Finish Today`s Work".tr),
              ),
              Obx(() {
                return controller.posStream.value["seconds"] != null
                    ? CounterWorkedFor(
                        counterFormat: controller.counterFormat(
                            controller.posStream.value["seconds"]),
                      )
                    : Container();
              }),
              Obx(() {
                return controller.isGPSdisable.value ||
                        !controller.isconnect.value
                    ? ErrorLayout(
                        errorMessage: controller.errorMessagge(),
                      )
                    : Container();
              })
            ],
          ),
        ),
      ),
    );
  }
}
