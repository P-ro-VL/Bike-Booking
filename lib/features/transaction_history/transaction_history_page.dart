import 'package:book_bike/data/entity/transaction_history.dart';
import 'package:book_bike/global_controller.dart';
import 'package:book_bike/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
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
          Ln.i?.historyItitle ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: controller.transactions
              .map((element) => _buildItem(element))
              .toList(),
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  Widget _buildItem(TransactionEntity transaction) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {},
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${Ln.i?.historyItransactionId} ${transaction.id ?? '--'}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(children: [
                    const Icon(
                      Icons.timelapse,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                        '${Ln.i?.historyItimestamp}: ${transaction.timestamp!.formatDate}'),
                  ]),
                  Row(children: [
                    const Icon(
                      Icons.podcasts,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                        '${Ln.i?.historyItransactionType}: ${transaction.type?.display ?? '--'}'),
                  ]),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Icon(
                transaction.type?.icon,
                color: transaction.type?.color,
              ),
              Text(transaction.amount!.formatMoney)
            ],
          ).paddingAll(16),
        ],
      ).paddingAll(12),
    );
  }
}
