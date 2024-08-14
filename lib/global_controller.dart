import 'dart:math';

import 'package:book_bike/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'data/entity/bike_entity.dart';
import 'data/entity/journey_entity.dart';
import 'data/entity/station_entity.dart';
import 'data/entity/transaction_history.dart';
import 'data/entity/user_entity.dart';

class GlobalController extends GetxController {
  final userRepository = UserRepositoryImpl();

  final user = Rxn<UserEntity>();
  final transactions = RxList<TransactionEntity>();
  final stations = RxList();
  final journeys = RxList<JourneyEntity>();
  final bikes = RxList<BikeEntity>();

  final fromLat = 20.997252488929842;
  final fromLng = 105.86712242384023;
  @override
  void onInit() {
    initTransactions();
    initStations();
    initJourneys();
    initBikes();

    super.onInit();
  }

  List<BikeEntity> getBikes(int stationId) {
    return bikes.where((e) => e.stationId == stationId).toList();
  }

  Future<String> login(
      {required String phone, required String password}) async {
    final users = await userRepository.getUsers();
    try {
      final account = users
          .firstWhere((acc) => acc.phone == phone && acc.password == password);
      user.value = account;
      return 'success';
    } catch (_) {
      return 'failed';
    }
  }

  void initJourneys() {
    for (var i = 0; i < 10; i++) {
      double offsetX = Random.secure().nextDouble() / 80;
      double offsetY = Random.secure().nextDouble() / 80;

      double negavX = Random.secure().nextBool() ? -1 : 1;
      double negavY = Random.secure().nextBool() ? -1 : 1;

      journeys.add(JourneyEntity(
        id: 'JRN$i',
        fromTime: DateTime.now().millisecondsSinceEpoch,
        toTime: DateTime.now().millisecondsSinceEpoch,
        kcalAbsorbed: Random.secure().nextInt(2560),
        fromLatLng: Offset(fromLat, fromLng),
        toLatLng:
            Offset(fromLat + negavX * offsetX, fromLng + negavY * offsetY),
      ));
    }
  }

  void initStations() async {
    stations.addAll(await userRepository.getStations());
  }

  void initBikes() async {
    bikes.addAll(await userRepository.getBikes());
  }

  void initTransactions() {
    for (var i = 0; i < 20; i++) {
      transactions.add(TransactionEntity(
        id: 'BRTHS${i.toStringAsFixed(5)}',
        timestamp: DateTime.now().millisecondsSinceEpoch,
        amount: Random.secure().nextInt(500000),
        type: Random.secure().nextBool()
            ? TransactionType.deposit_money
            : TransactionType.rent_bike,
      ));
    }
  }
}
