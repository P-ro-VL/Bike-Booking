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

  // List<int> a = [2238, 3837, 5076, 5391, 6529, 6721, 7981, 8213, 8433, 9674];

  // final supabase = Supabase.instance.client;
  // for (int i = 0; i < 1000; i++) {
  //   try {
  //     await supabase.from('XEDAP').insert({
  //       'MAXE': (Random.secure().nextDouble() * 1000).toInt(),
  //       'MATX': a[Random.secure().nextInt(a.length)],
  //       'TRANGTHAI': Random.secure().nextBool() ? 'Trống' : 'Đang sử dụng',
  //       'TINHTRANG': switch (Random.secure().nextInt(3)) {
  //         0 => 'Bình thường',
  //         1 => 'Hỏng',
  //         2 => 'Đang sửa chữa',
  //         _ => ''
  //       },
  //       'PIN': Random.secure().nextInt(100)
  //     });
  //   } catch (_) {}
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
