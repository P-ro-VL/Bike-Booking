import 'package:book_bike/data/entity/journey_entity.dart';
import 'package:book_bike/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../global_controller.dart';
import '../../l10n/app_l18.dart';

class JourneyHistoryPage extends StatelessWidget {
  JourneyHistoryPage({super.key});

  final controller = Get.find<GlobalController>();

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
          '${Ln.i?.journeyIhistoryTitle ?? ''} (${controller.journeys.length})',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: controller.journeys
              .map((element) => _buildItem(context, element))
              .toList(),
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildItem(BuildContext context, JourneyEntity journey) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            showDragHandle: true,
            context: context,
            builder: (context) => SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(height: 300, child: _buildMap(journey)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${Ln.i?.journeyIjourneyId} ${journey.id ?? '--'}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                const Row(children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  // Text(
                                  //     '${Ln.i?.journeyIstartTime}: ${journey.fromTime!.formatDate}'),
                                ]),
                                const Row(children: [
                                  Icon(
                                    Icons.timelapse,
                                    size: 16,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  // Text(
                                  //     '${Ln.i?.journeyIendTime}: ${journey.toTime!.formatDate}'),
                                ]),
                                Row(children: [
                                  const Icon(
                                    Icons.fireplace,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                      '${Ln.i?.journeyIabsorbedKcal}: ${journey.id!} kcal'),
                                ]),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '${journey.length}',
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700),
                                ),
                                const Text('km'),
                              ],
                            )
                          ],
                        ).paddingAll(12),
                      ],
                    ),
                  ),
                ));
      },
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${Ln.i?.journeyIjourneyId} ${journey.id ?? '--'}',
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
                  Text('${Ln.i?.journeyIBikeId}: ${journey.bikeId}'),
                ]),
                Row(children: [
                  const Icon(
                    Icons.star,
                    size: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text('${Ln.i?.journeyIrating}: '),
                  if (journey.rating == 0)
                    Text(Ln.i?.journeyInoRating ?? '',
                        style: TextStyle(color: Colors.black38)),
                  for (var i = 0; i < journey.rating!; i++)
                    Icon(
                      Icons.star,
                      size: 12,
                      color: Colors.yellow[800],
                    )
                ]),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.black26,
            ).paddingAll(16),
          ],
        ).paddingAll(12),
      ),
    );
  }

  Widget _buildMap(JourneyEntity journey) {
    final fromLat = journey.fromLatLng!.dx;
    final fromLng = journey.fromLatLng!.dy;

    final toLat = journey.toLatLng!.dx;
    final toLng = journey.toLatLng!.dy;

    final centerLat = (fromLat + toLat) / 2.0;
    final centerLng = (fromLng + toLng) / 2.0;

    return FlutterMap(
      options: MapOptions(
        initialCenter:
            LatLng(centerLat, centerLng), // Center the map over London
        initialZoom: 15,
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://tile.openstreetmap.org/{z}/{x}/{y}.png', // OSMF's Tile Server
          userAgentPackageName: 'com.example.app',
          maxNativeZoom:
              19, // Scale tiles when the server doesn't support higher zoom levels
        ),
        MarkerLayer(markers: [
          Marker(
              width: 200,
              height: 100,
              point: LatLng(fromLat, fromLng),
              child: Column(
                children: [
                  const Icon(
                    CupertinoIcons.map_pin,
                    size: 32,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.red),
                    child: Text(
                      Ln.i?.journeyIstartPoint ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )),
          Marker(
              width: 200,
              height: 100,
              point: LatLng(toLat, toLng),
              child: Column(
                children: [
                  const Icon(
                    CupertinoIcons.map_pin,
                    size: 32,
                    color: Colors.blue,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.blue),
                    child: Text(
                      Ln.i?.journeyIendPoint ?? '',
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ))
        ])
      ],
    );
  }
}
