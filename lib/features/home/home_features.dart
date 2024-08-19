import 'package:book_bike/features/deposit_money/deposit_money_page.dart';
import 'package:book_bike/features/journey_history/journey_history_page.dart';
import 'package:book_bike/features/station/list_station_page.dart';
import 'package:book_bike/features/transaction_history/transaction_history_page.dart';
import 'package:book_bike/features/user_info/user_info.dart';
import 'package:book_bike/global_controller.dart';
import 'package:book_bike/l10n/app_l18.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../book_bike/book_bike_in_journey.dart';
import '../book_bike/book_bike_qr_scan.dart';

String huongDan =
    "Tải ứng dụng về điện thoại của bạn.\nĐăng ký tài khoản bằng số điện thoại hoặc email.\nChọn điểm đón và điểm trả xe trên bản đồ.\nChọn loại xe đạp phù hợp với nhu cầu của bạn.\nQuét mã QR trên xe đạp để bắt đầu chuyến đi.\nKết thúc chuyến đi bằng cách trả xe vào đúng khu vực quy định.\nKiểm tra hóa đơn và thanh toán qua ứng dụng.";

List<HomeFeature> features = [
  HomeFeature(
      name: 'Trạm xe',
      icon: Icons.pedal_bike,
      color: Colors.orange,
      onClick: () {
        Get.to(ListStationPage());
      }),
  HomeFeature(
      name: 'Lịch sử\ngiao dịch',
      icon: Icons.timer,
      color: Colors.green,
      onClick: () {
        Get.to(const TransactionHistoryPage());
      }),
  HomeFeature(
      name: 'Lịch sử\nchuyến đi',
      icon: Icons.map,
      color: Colors.blue,
      onClick: () {
        Get.to(JourneyHistoryPage());
      }),
  HomeFeature(
      name: 'Thuê xe',
      icon: Icons.qr_code,
      color: Colors.red,
      onClick: () {
        final controller = Get.find<GlobalController>();
        Get.to(const BookBikeQRScan());
      }),
  HomeFeature(
      name: 'Nạp tiền',
      icon: Icons.money,
      color: Colors.purple,
      onClick: () {
        Get.to(DepositMoneyPage());
      }),
  HomeFeature(
      name: 'Hướng dẫn\nsử dụng',
      icon: Icons.book,
      color: Colors.pink,
      onClick: () {
        showCupertinoDialog(
            context: Get.context!,
            builder: (_) => AlertDialog(
                  content: SingleChildScrollView(
                    child: Text(huongDan),
                  ).paddingAll(12),
                  actions: [
                    CupertinoDialogAction(
                        onPressed: () {
                          Get.back();
                        },
                        isDefaultAction: true,
                        child: Text(Ln.i?.commonIunderstand ?? ''))
                  ],
                ));
      }),
];

class HomeFeature {
  final String name;
  final IconData icon;
  final Color? color;
  final Function()? onClick;

  HomeFeature({
    required this.name,
    required this.icon,
    required this.color,
    this.onClick,
  });
}
