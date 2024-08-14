import 'bike_entity.dart';

class StationEntity {
  final String? id;
  final String? address;
  final String? name;
  final List<BikeEntity>? bikes;
  final num? lat;
  final num? lng;

  StationEntity({
    this.id,
    this.address,
    this.name,
    this.bikes,
    this.lat,
    this.lng,
  });
}
