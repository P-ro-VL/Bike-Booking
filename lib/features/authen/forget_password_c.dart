import 'package:book_bike/l10n/app_l18.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ForgetPasswordController extends GetxController {
  final step = RxInt(1);

  var phoneNumber = '';

  var newPassword = '';
  var reenterNewPassword = '';

  Future<void> changePassword() async {
    final supabase = Supabase.instance.client;

    await supabase
        .from('NGUOIDUNG')
        .update({'MATKHAU': newPassword}).eq('SDT', phoneNumber);
    Get.showSnackbar(GetSnackBar(
      message: Ln.i?.authIretakePasswordSuccess,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 3),
      showProgressIndicator: true,
    ));
  }
}
