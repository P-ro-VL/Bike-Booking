import 'package:book_bike/data/entity/bike_entity.dart';
import 'package:book_bike/data/entity/station_entity.dart';
import 'package:book_bike/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class DetailStationPage extends StatelessWidget {
  final StationEntity station;

  DetailStationPage({required this.station, super.key});

  final controller = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back),
        ),
        title: Column(
          children: [
            Text(
              Ln.i?.stationIinformation ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              station.name ?? '--',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: (controller.getBikes(station.id ?? -1)).isEmpty
              ? [
                  Image.asset('assets/no_data.jpg'),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: Text(
                      Ln.i?.commonInoData ?? '',
                      style: TextStyle(color: Colors.black26, fontSize: 16),
                    ),
                  )
                ]
              : (controller.getBikes(station.id ?? -1))
                  .map((element) => _buildItem(element as BikeEntity))
                  .toList()
            ..add(const SizedBox(
              height: 32,
            )),
        ),
      ).paddingSymmetric(horizontal: 12),
    );
  }

  Widget _buildItem(BikeEntity bike) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${Ln.i?.stationIbike} ${bike.id ?? '--'}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(children: [
                const Icon(
                  Icons.battery_charging_full,
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('${Ln.i?.stationIbikeBattery}: ${bike.battery}%'),
              ]),
              Row(children: [
                const Icon(
                  Icons.cell_tower,
                  size: 16,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text('${Ln.i?.commonIstatus}: '),
                _buildStatusTag(bike),
              ]),
            ],
          ),
          const Icon(
            Icons.pedal_bike,
            color: Colors.black26,
            size: 64,
          ).paddingAll(16),
        ],
      ).paddingAll(12),
    );
  }

  Widget _buildStatusTag(BikeEntity bike) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        // color: bike.status ,
      ),
      child: Text(
        bike.status ?? '--',
        style: const TextStyle(color: Colors.blue),
      ).paddingAll(4),
    );
  }
}
