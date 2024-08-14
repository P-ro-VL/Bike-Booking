import 'package:book_bike/features/home/home_page.dart';
import 'package:book_bike/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class AuthenticationPageController extends GetxController {
  final controller = Get.find<GlobalController>();

  final formKey = GlobalKey<FormState>();

  final phoneFieldError = RxnString();
  final passwordFieldError = RxnString();
  final emailFieldError = RxnString();
  final reEnterPasswordError = RxnString();

  final pageState = RxString('login');

  var phone = '';
  var password = '';

  void submit() async {
    bool result = formKey.currentState!.validate();

    if (!result) return;

    print('SDT: $phone, PASS: $password');
    final authResult = await controller.login(phone: phone, password: password);
    if (authResult == 'success') {
      Get.to(const HomePage());
    } else {
      Get.showSnackbar(GetSnackBar(
        message: Ln.i?.authIloginFailed ?? '',
      ));
    }
  }

  void goToLogin() {
    pageState.value = 'login';
  }

  void goToRegister() {
    pageState.value = 'register';
  }
}
