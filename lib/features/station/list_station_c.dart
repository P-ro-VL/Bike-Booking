import 'dart:math';

import 'package:book_bike/data/entity/bike_entity.dart';
import 'package:book_bike/data/entity/station_entity.dart';
import 'package:book_bike/global_controller.dart';
import 'package:get/get.dart';

class ListStationPageController extends GetxController {
  final controller = Get.find<GlobalController>();

  final origin = [];
  final stations = RxList();

  @override
  void onInit() {
    origin.assignAll(controller.stations);
    stations.assignAll(origin);
    super.onInit();
  }

  void doSearch(String text) {
    final filterResult =
        origin.where((e) => e.name?.toLowerCase().contains(text.toLowerCase()));

    stations.assignAll(filterResult);
  }
}
