import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

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
        title: Center(
          child: Column(
            children: [
              Text(
                Ln.i?.stationIinformation ?? '',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
              ),
              Text(
                station.name ?? '--',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: (controller.getBikes(station.id ?? -1))
              .map((element) => _buildItem(element as BikeEntity))
              .toList()
            ..add(const SizedBox(
              height: 32,
            )),
        ),
      ).paddingSymmetric(horizontal: 12),
    );
  }
}
