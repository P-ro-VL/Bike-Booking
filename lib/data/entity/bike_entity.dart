import 'package:flutter/material.dart';

import '../../l10n/app_l18.dart';

class BikeEntity {
  final String? id;
  final double? battery;
  final BikeStatus status;

  BikeEntity({
    this.id,
    this.battery,
    this.status = BikeStatus.available,
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
