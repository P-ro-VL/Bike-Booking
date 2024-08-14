import 'package:flutter/material.dart';

import '../../l10n/app_l18.dart';

class TransactionEntity {
  final String? id;
  final num? timestamp;
  final num? amount;
  final TransactionType? type;

  TransactionEntity({
    this.id,
    this.timestamp,
    this.amount,
    this.type,
  });
}

enum TransactionType { deposit_money, rent_bike }

extension TransactionTypeExts on TransactionType {
  String get display => switch (this) {
        TransactionType.deposit_money => Ln.i?.historyIdepositMoney ?? '',
        TransactionType.rent_bike => Ln.i?.historyIrentBike ?? ''
      };

  Color get color => switch (this) {
        TransactionType.deposit_money => Colors.green,
        TransactionType.rent_bike => Colors.red
      };

  IconData get icon => switch (this) {
        TransactionType.deposit_money => Icons.attach_money,
        TransactionType.rent_bike => Icons.pedal_bike_rounded
      };
}
