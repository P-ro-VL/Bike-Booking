import 'package:book_bike/features/authen/authen_c.dart';
import 'package:book_bike/features/authen/login_page.dart';
import 'package:book_bike/features/authen/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global_controller.dart';

class AuthenticationPage extends StatelessWidget {
  final _ = Get.put(GlobalController(), permanent: true);
  final controller = Get.put(AuthenticationPageController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.pageState.value == 'login'
        ? const LoginPage()
        : const RegisterPage());
  }
}
