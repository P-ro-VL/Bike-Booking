import 'package:book_bike/common/widgets/ds_text_form_field.dart';
import 'package:book_bike/features/authen/forget_password_c.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final controller = Get.put(ForgetPasswordController());

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
<<<<<<< HEAD
      body: Obx(() => controller.step.value == 1
          ? ForgetPasswordStep1()
          : ForgotPasswordStep2()),
=======
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset('assets/retake_password_bgr.jpg'),
          ).paddingOnly(bottom: 20),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Obx(() => controller.step.value == 1
                  ? ForgetPasswordStep1()
                  : ForgotPasswordStep2()),
            ],
          ),
        ],
      ),
>>>>>>> f27c27c65695bae3771de1235d29a3e4cbd941ff
    );
  }
}

class ForgetPasswordStep1 extends StatelessWidget {
  ForgetPasswordStep1({super.key});

  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ForgetPasswordController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Form(
          key: _formKey,
          child: DSTextFormField(
            title: Ln.i?.commonIphoneNumber ?? '',
            validator: (newText) {
              if (newText == null || newText.isEmpty) {
                return Ln.i?.commonIrequiredField;
              }
              if (newText.length != 10) {
                return Ln.i?.authIinvalidPhoneNumber;
              }
              return null;
            },
            onChanged: (newText) {
              controller.phoneNumber = newText;
            },
            keyboardType: TextInputType.phone,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextButton(
            onPressed: () {
              validate();
            },
            child: Text(Ln.i?.commonInext ?? ''))
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  void validate() {
    final result = _formKey.currentState?.validate();
    if (result != true) {
      return;
    }
    controller.step.value = 2;
  }
}

class ForgotPasswordStep2 extends StatelessWidget {
  ForgotPasswordStep2({super.key});

  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 8,
        ),
        Form(
            child: Column(
          children: [
            DSTextFormField(
              title: Ln.i?.authInewPassword ?? '',
              validator: (newText) {
                if (newText == null || newText.isEmpty) {
                  return Ln.i?.commonIrequiredField;
                }
                return null;
              },
              onChanged: (newText) {
                controller.newPassword = newText;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            DSTextFormField(
              title: Ln.i?.authIreenterNewPassword ?? '',
              onChanged: (newText) {
                controller.reenterNewPassword = newText;
              },
              validator: (newText) {
                if (newText == null || newText.isEmpty) {
                  return Ln.i?.commonIrequiredField;
                }
                if (controller.reenterNewPassword != newText) {
                  return Ln.i?.authIpasswordNotMatch;
                }
                return null;
              },
            ),
          ],
        )),
        const SizedBox(
          height: 16,
        ),
        TextButton(
            onPressed: () {}, child: Text(Ln.i?.commonIchangePassword ?? ''))
      ],
    ).paddingSymmetric(horizontal: 16);
  }

  void validate() {
    final result = _formKey.currentState?.validate();

    if (result != true) {
      return;
    }

    controller.changePassword();
  }
}
