import 'package:book_bike/common/widgets/ds_text_form_field.dart';
import 'package:book_bike/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../l10n/app_l18.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final newPassword = RxString('');
  final confirmNewPassword = RxString('');
  final oldPassword = RxString('');

  final notMatch = RxBool(false);

  final formKey = GlobalKey<FormState>();

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
          Ln.i?.commonIchangePassword ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            DSTextFormField(
              title: Ln.i?.authIcurrentPassword ?? '',
              isPassword: true,
              onChanged: (newText) {
                oldPassword.value = newText;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DSTextFormField(
              title: Ln.i?.authInewPassword ?? '',
              isPassword: true,
              validator: (newText) {
                if (newText == null || newText.isEmpty)
                  return Ln.i?.commonIrequiredField;
                return null;
              },
              onChanged: (newText) {
                newPassword.value = newText;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DSTextFormField(
              title: Ln.i?.authIreenterNewPassword ?? '',
              isPassword: true,
              validator: (newText) {
                if (newText == null || newText.isEmpty)
                  return Ln.i?.commonIrequiredField;
                if (newText != newPassword.value) {
                  notMatch.value = true;
                  return Ln.i?.authIpasswordNotMatch;
                }
                notMatch.value = false;
                return null;
              },
              onChanged: (newText) {
                confirmNewPassword.value = newText;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {
                  changePassword();
                },
                child: Text(Ln.i?.commonIchangePassword ?? ''))
          ],
        ).paddingSymmetric(horizontal: 16),
      ),
    );
  }

  final controller = Get.find<GlobalController>();

  void changePassword() async {
    final result = formKey.currentState?.validate();
    if (result == false) return;

    if (controller.user.value?.password != oldPassword.value) {
      Get.showSnackbar(GetSnackBar(
        message: Ln.i?.authIoldPasswordNotCorrect,
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (notMatch.value) {
      Get.showSnackbar(GetSnackBar(
        message: Ln.i?.authIpasswordNotMatch,
        backgroundColor: Colors.red,
      ));
      return;
    }

    final supabase = Supabase.instance.client;
    await supabase.from('NGUOIDUNG').update({'MATKHAU': newPassword.value}).eq(
        'MAND', controller.user.value!.userId!);

    Get.back();
    Get.showSnackbar(GetSnackBar(
      message: Ln.i?.authIchangePasswordSuccess,
      backgroundColor: Colors.green,
    ));
  }
}
