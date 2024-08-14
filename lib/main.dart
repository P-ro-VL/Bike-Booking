import 'dart:math';

import 'package:book_bike/features/authen/authen_page.dart';
import 'package:book_bike/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://podixwvsfklaijdvaytf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InBvZGl4d3ZzZmtsYWlqZHZheXRmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjMyMDQzNzcsImV4cCI6MjAzODc4MDM3N30.LYWtVq69N7quL3mTkLMLkK5M3gQyYvHqI_PSEmLrAnc',
  );

  // final supabase = Supabase.instance.client;
  // for (int i = 0; i < 10; i++) {
  //   await supabase.from('TAIKHOAN').insert({
  //     'MATK': (Random.secure().nextDouble() * 10000).toInt().toString(),
  //     'MAND': (Random.secure().nextDouble() * 10000).toInt().toString(),
  //     'MATKHAU': '123456',
  //     'TENNGUOIDUNG': 'Nguyễn Thuý Hiền',
  //     'SODUTAIKHOAN': Random.secure().nextInt(1000000),
  //     'SDT': '0${916622388 + i}',
  //     'EMAIL': 'hiennt@gmail.com'
  //   });
  // }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final currentLocale = Locale(Intl.shortLocale(Intl.systemLocale));

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Thuê xe đạp',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      locale: currentLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialBinding: BindingsBuilder(() {
        Get.put(GlobalController(), permanent: true);
      }),
      home: AuthenticationPage(),
    );
  }
}
