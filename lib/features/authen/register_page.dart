import 'package:book_bike/common/widgets/ds_text_form_field.dart';
import 'package:book_bike/features/authen/authen_c.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final controller = Get.find<AuthenticationPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Form(
        key: controller.formKey,
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Ln.i?.authIregisterTitle ?? '',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              DSTextFormField(
                title: Ln.i?.authIfullName ?? '',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return Ln.i?.commonIrequiredField;
                  }
                  return null;
                },
                onChanged: (newText) {
                  controller.name = newText;
                },
                errorText: controller.nameFieldError.value,
              ),
              const SizedBox(
                height: 8,
              ),
              DSTextFormField(
                title: Ln.i?.commonIphoneNumber ?? '',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return Ln.i?.commonIrequiredField;
                  }
                  if (text.length != 10) return Ln.i?.authIinvalidPhoneNumber;
                  return null;
                },
                onChanged: (newText) {
                  controller.phone = newText;
                },
                keyboardType: TextInputType.phone,
                errorText: controller.phoneFieldError.value,
              ),
              const SizedBox(
                height: 8,
              ),
              DSTextFormField(
                title: Ln.i?.commonIemail ?? '',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return Ln.i?.commonIrequiredField;
                  }
                  if (!text.contains('@')) return Ln.i?.authIinvalidEmail;
                  return null;
                },
                onChanged: (newText) {
                  controller.email = newText;
                },
                errorText: controller.emailFieldError.value,
              ),
              const SizedBox(
                height: 8,
              ),
              DSTextFormField(
                title: Ln.i?.commonIpassword ?? '',
                onChanged: (text) {
                  controller.password = text;
                },
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return Ln.i?.commonIrequiredField;
                  }
                  return null;
                },
                isPassword: true,
                errorText: controller.passwordFieldError.value,
              ),
              const SizedBox(
                height: 8,
              ),
              DSTextFormField(
                title: Ln.i?.authIreenterPassword ?? '',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return Ln.i?.commonIrequiredField;
                  }
                  return text == controller.password
                      ? null
                      : Ln.i?.authIpasswordNotMatch;
                },
                isPassword: true,
                errorText: controller.passwordFieldError.value,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.register();
                  },
                  child: Text(Ln.i?.authIregister ?? '')),
              const SizedBox(
                height: 30,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: Ln.i?.authIhaveAccount),
                TextSpan(
                    text: Ln.i?.authIbackToLogin,
                    style: TextStyle(
                        color: Colors.blue[800],
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue[800]),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller.goToLogin();
                      }),
              ]))
            ],
          ),
        ),
      ).paddingAll(16)),
    );
  }
}
