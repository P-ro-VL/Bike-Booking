import 'package:book_bike/data/entity/bike_entity.dart';
import 'package:book_bike/data/entity/journey_entity.dart';
import 'package:book_bike/data/entity/station_entity.dart';
import 'package:book_bike/data/entity/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserRepository {
  Future<List<UserEntity?>> getUsers();

  Future<List<StationEntity>> getStations();

  Future<List<BikeEntity>> getBikes();

  Future<List<JourneyEntity>> getJourneys();
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<List<UserEntity?>> getUsers() async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('NGUOIDUNG').select('*');
    final result = <UserEntity>[];

    for (var map in data) {
      final user = UserEntity(
          accountId: map['MATK'],
          userId: map['MAND'],
          password: map['MATKHAU'],
          displayName: map['TENNGUOIDUNG'],
          money: map['SODUTAIKHOAN'],
          phone: map['SDT'],
          email: map['EMAIL']);

      result.add(user);
    }

    return result;
  }

  @override
  Future<List<BikeEntity>> getBikes() async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('XEDAP').select('*');
    final result = <BikeEntity>[];

    for (var map in data) {
      final bike = BikeEntity(
        id: map['MAXE'],
        stationId: map['MATX'],
        status: map['TRANGTHAI'],
        battery: map['PIN'],
        state: map['TINHTRANG'],
      );

      result.add(bike);
    }

    return result;
  }

  @override
  Future<List<StationEntity>> getStations() async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('TRAMXE').select('*');
    final result = <StationEntity>[];

    for (var map in data) {
      final station = StationEntity(
        id: map['MATX'],
        name: map['TENTRAMXE'],
        lat: map['LAT'],
        lng: map['LONG'],
      );

      result.add(station);
    }

    return result;
  }

  @override
  Future<List<JourneyEntity>> getJourneys() async {
    final supabase = Supabase.instance.client;

    final data = await supabase.from('CHUYENDI').select('*');
    final result = <JourneyEntity>[];

    for (var map in data) {
      final startPoint = Offset(map['LATSTART'], map['LONGSTART']);
      final endPoint = Offset(map['LATEND'], map['LONGEND']);

      final journey = JourneyEntity(
        id: map['MACD'],
        bikeId: map['MAXE'],
        accountId: map['MATK'],
        fromLatLng: startPoint,
        toLatLng: endPoint,
        rating: map['DANHGIA'],
      );

      result.add(journey);
    }

    return result;
  }
}
