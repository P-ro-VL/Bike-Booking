import 'package:flutter/material.dart';

import '../../l10n/app_l18.dart';

class BikeEntity {
  final int? id;
  final int? stationId;
  final num? battery;
  final String? status;
  final String? state;

  BikeEntity({
    this.id,
    this.battery,
    this.stationId,
    this.status,
    this.state,
  });
}

enum BikeStatus { available, rented }

extension BikeStatusExts on BikeStatus {
  String get displayName => switch (this) {
        BikeStatus.available => Ln.i?.stationIbikeAvailable ?? '',
        BikeStatus.rented => Ln.i?.stationIbikeRented ?? ''
      };

  Color get color => switch (this) {
        BikeStatus.available => Colors.green,
        BikeStatus.rented => Colors.red
      };
}
