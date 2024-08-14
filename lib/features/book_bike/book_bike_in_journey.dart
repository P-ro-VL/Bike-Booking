import 'package:book_bike/data/entity/bike_entity.dart';
import 'package:book_bike/data/entity/station_entity.dart';
import 'package:book_bike/global_controller.dart';
import 'package:book_bike/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../l10n/app_l18.dart';

class BookBikeInJourneyPage extends StatefulWidget {
  final BikeEntity bike;
  final StationEntity station;

  const BookBikeInJourneyPage(
      {required this.bike, required this.station, super.key});

  @override
  State<BookBikeInJourneyPage> createState() => _BookBikeInJourneyPageState();
}

class _BookBikeInJourneyPageState extends State<BookBikeInJourneyPage> {
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
          Ln.i?.journeyIhistoryTitle ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: _buildBody,
    );
  }

  Widget get _buildBody => Stack(
        children: [
          _buildMap,
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (Ln.i?.bikeIbikeId ?? '')
                        .replaceAll('%s', widget.bike.id.toString() ?? '--'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const Text(
                            '0 km',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text(Ln.i?.bikeIwentLength ?? '--'),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black26,
                      ),
                      Column(
                        children: [
                          const Text(
                            '32 đ',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text(Ln.i?.bikeImoneySpent ?? '--'),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        color: Colors.black26,
                      ),
                      Column(
                        children: [
                          Text(
                            controller.user.value!.money!.formatMoney,
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          Text(Ln.i?.bikeIremainingMoney ?? '--'),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Text(
                        Ln.i?.bikeIendJourneyAction ?? '',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.red),
                      ),
                    ),
                  )
                ],
              ).paddingAll(12),
            ).paddingAll(16),
          )
        ],
      );

  Widget get _buildMap => FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(
              widget.station.lat?.toDouble() ?? 0,
              widget.station.lng?.toDouble() ??
                  0), // Center the map over London
          initialZoom: 19,
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
                width: 100,
                height: 100,
                point: LatLng(widget.station.lat?.toDouble() ?? 0,
                    widget.station.lng?.toDouble() ?? 0),
                child: Column(
                  children: [
                    const Icon(
                      CupertinoIcons.map_pin,
                      size: 32,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.red),
                      child: Text(
                        widget.station.name ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )),
            Marker(
                width: 100,
                height: 100,
                point: LatLng(widget.station.lat?.toDouble() ?? 0,
                    widget.station.lng?.toDouble() ?? 0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.person,
                      size: 32,
                      color: Colors.green,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green),
                      child: Text(
                        'Bạn',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ))
          ])
        ],
      );
}
