import 'package:book_bike/common/widgets/ds_text_form_field.dart';
import 'package:book_bike/features/authen/authen_c.dart';
import 'package:book_bike/features/authen/forget_password.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../l10n/app_l18.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.find<AuthenticationPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
              child: Form(
            key: controller.formKey,
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    Ln.i?.authIloginTitle ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  DSTextFormField(
                    title: Ln.i?.commonIphoneNumber ?? '',
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return Ln.i?.commonIrequiredField;
                      }
                      if (text.length != 10)
                        return Ln.i?.authIinvalidPhoneNumber;
                      return null;
                    },
                    onChanged: (text) => controller.phone = text,
                    keyboardType: TextInputType.phone,
                    errorText: controller.phoneFieldError.value,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  DSTextFormField(
                    title: Ln.i?.commonIpassword ?? '',
                    validator: (text) {
                      if (text == null || text.isEmpty) {
                        return Ln.i?.commonIrequiredField;
                      }
                      return null;
                    },
                    onChanged: (text) => controller.password = text,
                    isPassword: true,
                    errorText: controller.passwordFieldError.value,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        controller.login();
                      },
                      child: Text(Ln.i?.authIloginTitle ?? '')),
                  const SizedBox(
                    height: 30,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(text: Ln.i?.authInotHaveAccount),
                    TextSpan(
                        text: Ln.i?.authIregisterNow,
                        style: TextStyle(
                            color: Colors.blue[800],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue[800]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            controller.goToRegister();
                          }),
                  ])),
                  const SizedBox(
                    height: 24,
                  ),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: Ln.i?.authIforgetPassword,
                        style: TextStyle(
                            color: Colors.blue[800],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue[800]),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(ForgotPasswordPage());
                          }),
                  ])),
                  Image.asset(
                    'assets/login_screen_bgr.jpg',
                    width: 300,
                  ),
                ],
              ),
<<<<<<< HEAD
              const SizedBox(
                height: 24,
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
                onChanged: (text) => controller.phone = text,
                keyboardType: TextInputType.phone,
                errorText: controller.phoneFieldError.value,
              ),
              const SizedBox(
                height: 8,
              ),
              DSTextFormField(
                title: Ln.i?.commonIpassword ?? '',
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return Ln.i?.commonIrequiredField;
                  }
                  return null;
                },
                onChanged: (text) => controller.password = text,
                isPassword: true,
                errorText: controller.passwordFieldError.value,
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.login();
                  },
                  child: Text(Ln.i?.authIloginTitle ?? '')),
              const SizedBox(
                height: 30,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(text: Ln.i?.authInotHaveAccount),
                TextSpan(
                    text: Ln.i?.authIregisterNow,
                    style: TextStyle(
                        color: Colors.blue[800],
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue[800]),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        controller.goToRegister();
                      }),
              ])),
              const SizedBox(
                height: 24,
              ),
              Text.rich(TextSpan(children: [
                TextSpan(
                    text: Ln.i?.authIforgetPassword,
                    style: TextStyle(
                        color: Colors.blue[800],
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.blue[800]),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Get.to(ForgotPasswordPage());
                      }),
              ]))
            ],
          ),
        ),
      ).paddingAll(16)),
=======
            ),
          ).paddingAll(16)),
        ],
      ),
>>>>>>> f27c27c65695bae3771de1235d29a3e4cbd941ff
    );
  }
}
