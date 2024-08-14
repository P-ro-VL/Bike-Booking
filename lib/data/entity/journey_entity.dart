import 'dart:math';

import 'package:flutter/material.dart';

class JourneyEntity {
  final String? id;
  final num? fromTime;
  final num? toTime;
  final num? kcalAbsorbed;

  final Offset? fromLatLng;
  final Offset? toLatLng;

  JourneyEntity({
    this.id,
    this.fromTime,
    this.toTime,
    this.kcalAbsorbed,
    this.fromLatLng,
    this.toLatLng,
  });

  num get length =>
      (haversine(fromLatLng!.dx, fromLatLng!.dy, toLatLng!.dx, toLatLng!.dy) *
              10)
          .floor() /
      10;

  double toRadians(double degree) {
    return degree * (pi / 180.0);
  }

  double haversine(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371; // Bán kính Trái Đất (km)

    // Chuyển đổi các tọa độ từ độ sang radian
    double lat1Rad = toRadians(lat1);
    double lon1Rad = toRadians(lon1);
    double lat2Rad = toRadians(lat2);
    double lon2Rad = toRadians(lon2);

    // Sự khác biệt giữa các vĩ độ và kinh độ
    double dLat = lat2Rad - lat1Rad;
    double dLon = lon2Rad - lon1Rad;

    // Công thức Haversine
    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    // Khoảng cách
    return R * c;
  }
}
