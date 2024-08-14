import 'package:book_bike/data/entity/station_entity.dart';
import 'package:book_bike/features/station/detail_station_page.dart';
import 'package:book_bike/features/station/station_direction_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';
import 'list_station_c.dart';

class ListStationPage extends StatelessWidget {
  ListStationPage({super.key});

  final controller = Get.put(ListStationPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Text(
          Ln.i?.stationIlistStation ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 8,
            ),
            SearchBar(
              elevation: const MaterialStatePropertyAll(0.5),
              onChanged: (text) {
                controller.doSearch(text);
              },
              hintText: Ln.i?.stationIsearchStation,
            ),
            const SizedBox(
              height: 8,
            ),
            Obx(
              () => Column(
                  children: controller.stations
                      .map((element) => _buildItem(element as StationEntity))
                      .toList()
                    ..add(const SizedBox(
                      height: 32,
                    ))),
            ),
          ],
        ).paddingSymmetric(horizontal: 12),
      ),
    );
  }

  Widget _buildItem(StationEntity station) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Get.to(DetailStationPage(station: station));
            },
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    station.name ?? '--',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    const Icon(
                      Icons.pedal_bike,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                        '${Ln.i?.stationInumberOfBikes}: ${station.bikes?.length}'),
                  ]),
                  Row(children: [
                    const Icon(
                      Icons.cell_tower,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                        '${Ln.i?.stationIstationAddress}: ${station.address ?? '--'}'),
                  ]),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(StationDrectionPage(
                station: station,
              ));
            },
            child: Card(
              color: Colors.blue[800],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: const Icon(
                Icons.directions,
                color: Colors.white,
              ).paddingAll(16),
            ),
          )
        ],
      ).paddingAll(12),
    );
  }
}
