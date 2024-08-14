import 'dart:math';

import 'package:book_bike/data/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/entity/bike_entity.dart';
import 'data/entity/journey_entity.dart';
import 'data/entity/station_entity.dart';
import 'data/entity/transaction_history.dart';
import 'data/entity/user_entity.dart';
import 'l10n/app_l18.dart';

class GlobalController extends GetxController {
  final userRepository = UserRepositoryImpl();

  final user = Rxn<UserEntity>();
  final transactions = RxList<TransactionEntity>();
  final stations = RxList<StationEntity>();
  final journeys = RxList<JourneyEntity>();
  final bikes = RxList<BikeEntity>();

  @override
  void onInit() {
    initTransactions();
    initStations();
    initJourneys();
    initBikes();

    super.onInit();
  }

  Future<void> updateUserInfo(Map<String, dynamic> data) async {
    final supabase = Supabase.instance.client;

    await supabase.from('NGUOIDUNG').update(data);
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

  Future<void> register({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    try {
      final supabase = Supabase.instance.client;
      await supabase.from('NGUOIDUNG').insert({
        'MAND': Random.secure().nextInt(100000),
        'MATKHAU': password,
        'TENNGUOIDUNG': name,
        'SODUTAIKHOAN': 0,
        'SDT': phone,
        'EMAIL': email,
      });
      Get.showSnackbar(GetSnackBar(
        message: Ln.i?.authIcreateAccSuccess,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        showProgressIndicator: true,
      ));
    } catch (_) {
      Get.showSnackbar(GetSnackBar(
        message: Ln.i?.commonIunknownError,
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        showProgressIndicator: true,
      ));
    }
  }

  void initJourneys() async {
    journeys.addAll(await userRepository.getJourneys());
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
