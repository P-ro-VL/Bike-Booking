import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Ln {
  static AppLocalizations? get i {
    if (Get.context == null) return null;
    return AppLocalizations.of(Get.context!);
  }

  static AppLocalizations? of(BuildContext i) {
    return AppLocalizations.of(i);
  }
}
