import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../data/entity/station_entity.dart';

class StationDrectionPage extends StatelessWidget {
  final StationEntity station;

  const StationDrectionPage({required this.station, super.key});

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
        title: Column(
          children: [
            Text(
              station.name ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
            ),
            Text(
              station.address ?? '--',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [Expanded(child: _buildMap)],
          )
        ],
      ),
    );
  }

  Widget get _buildMap => FlutterMap(
        options: MapOptions(
          initialCenter: LatLng(station.lat?.toDouble() ?? 0,
              station.lng?.toDouble() ?? 0), // Center the map over London
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
            (Marker(
                width: 100,
                height: 100,
                point: LatLng(
                    station.lat?.toDouble() ?? 0, station.lng?.toDouble() ?? 0),
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
                        station.name ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )))
          ])
        ],
      );
}
