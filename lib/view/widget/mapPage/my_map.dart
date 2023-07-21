import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lordsbox/controller/map_page_controller.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';

class MyMap extends StatelessWidget {
  const MyMap({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapPageController>();
    return Obx(() {
      return FlutterMap(
        mapController: controller.mapController,
        options: MapOptions(
          center: LatLng(
            controller.posStream.value["latitude"],
            controller.posStream.value["longitude"],
          ),
          zoom: 18,
        ),
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: null,
          ),
        ],
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.em.lordsbox',
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: LatLng(
                  controller.posStream.value["latitude"],
                  controller.posStream.value["longitude"],
                ),
                width: 80,
                height: 80,
                builder: (context) => Icon(
                  Icons.location_on,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ],
      );
    });
  }
}
