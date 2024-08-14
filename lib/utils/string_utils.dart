import 'package:intl/intl.dart';

extension NumberExtensions on num {
  String get formatMoney {
    final formatter = NumberFormat('#,###');
    return '${formatter.format(this)} đ';
  }

  String get formatDate {
    final formatter = DateFormat('HH:mm dd/MM/yyyy');
    return formatter.format(DateTime.fromMillisecondsSinceEpoch(toInt()));
  }
}
