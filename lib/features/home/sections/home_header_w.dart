import 'package:book_bike/features/authen/authen_page.dart';
import 'package:book_bike/global_controller.dart';
import 'package:book_bike/utils/string_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../l10n/app_l18.dart';

class HomeHeaderWidget extends StatelessWidget {
  HomeHeaderWidget({super.key});

  final controller = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                (Ln.i?.homeIhello ?? '').replaceAll(
                    '%s', controller.user.value?.displayName ?? '--'),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Obx(
                () => Text((Ln.i?.homeIuserMoney ?? '').replaceAll(
                    '%s', (controller.user.value?.money ?? 0).formatMoney)),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              showLogoutDialog();
            },
            child: const Icon(
              Icons.person,
              size: 24,
            ),
          ),
        ],
      ).paddingAll(16),
    );
  }

  void showLogoutDialog() {
    showDialog(
        context: Get.context!,
        builder: (builder) => AlertDialog(
              content: Text(Ln.i?.authIconfirmLogout ?? ''),
              actions: [
                TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(Ln.i?.commonIcancel ?? '')),
                TextButton(
                    onPressed: () {
                      Get.offAll(AuthenticationPage());
                    },
                    child: Text(Ln.i?.commonIconfirm ?? '')),
              ],
            ));
  }
}
