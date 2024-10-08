import 'dart:ffi';

import 'package:book_bike/common/widgets/ds_text_form_field.dart';
import 'package:book_bike/global_controller.dart';
import 'package:book_bike/utils/string_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class DepositMoneyPage extends StatelessWidget {
  DepositMoneyPage({super.key});

  final controller = Get.find<GlobalController>();
  final moneyValue = RxDouble(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              controller.user.refresh();
              Get.back();
            },
            child: const Icon(Icons.arrow_back),
          ),
          title: Text(
            Ln.i?.depositIdeposit ?? '',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        body: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Image.asset('assets/cash_screen_bgr.jpg'),
            ).paddingOnly(bottom: 20),
            Column(
              children: [
                const SizedBox(
                  height: 24,
                ),
                DSTextFormField(
                  title: Ln.i?.depositIdepositAmount ?? '',
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    moneyValue.value = double.parse(text);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (builder) => AlertDialog(
                              content: Container(
                                height: 450,
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      Ln.i?.depositIscanQRtitle ?? '',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                        (Ln.i?.depositIscanQRmessage ?? '')
                                            .replaceAll('%s',
                                                moneyValue.value.formatMoney),
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        )),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                        width: 256,
                                        height: 256,
                                        child: Image.network(
                                            'https://img.vietqr.io/image/techcombank-999999999-qr_only.jpg?amount=%s&addInfo=BOOK%20BIKE')),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          if (moneyValue.value <= 0) {
                                            Get.showSnackbar(GetSnackBar(
                                              backgroundColor: Colors.red,
                                              message:
                                                  Ln.i?.depositImustBePositive,
                                              duration:
                                                  const Duration(seconds: 3),
                                              showProgressIndicator: true,
                                            ));
                                            return;
                                          }
                                          controller.user.value!.money =
                                              ((controller.user.value?.money ??
                                                          0) +
                                                      moneyValue.value)
                                                  .toInt();
                                          controller.updateUserInfo({
                                            "SODUTAIKHOAN":
                                                controller.user.value!
                                          });
                                          Get.back();
                                          Get.showSnackbar(GetSnackBar(
                                            backgroundColor: Colors.green,
                                            message:
                                                (Ln.i?.depositIsuccess ?? '')
                                                    .replaceAll(
                                                        '%s',
                                                        moneyValue
                                                            .value.formatMoney),
                                            duration:
                                                const Duration(seconds: 3),
                                            showProgressIndicator: true,
                                          ));
                                        },
                                        child: Text(Ln.i?.commonIconfirm ?? ''))
                                  ],
                                ),
                              ),
                            ));
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        Ln.i?.depositIdeposit ?? '',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ).paddingSymmetric(horizontal: 16),
          ],
        ));
  }
}
