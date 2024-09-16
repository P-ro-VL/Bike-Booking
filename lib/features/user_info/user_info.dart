import 'package:book_bike/features/authen/authen_page.dart';
import 'package:book_bike/features/authen/change_password.dart';
import 'package:book_bike/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class UserInfoPage extends StatefulWidget {
  const UserInfoPage({super.key});

  @override
  State<UserInfoPage> createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
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
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 64,
          ),
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: Colors.black26,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                size: 48,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            controller.user.value?.displayName ?? '--',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            controller.user.value?.email ?? '--',
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
          const SizedBox(
            height: 64,
          ),
          GestureDetector(
            onTap: () {
              Get.to(ChangePasswordPage());
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.black12,
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.key,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(Ln.i?.commonIchangePassword ?? '',
                      style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          GestureDetector(
            onTap: () {
              showLogoutDialog();
            },
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.redAccent[100]!.withOpacity(0.4),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.door_back_door,
                    size: 24,
                    color: Colors.red,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    Ln.i?.commonIlogOut ?? '',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
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
