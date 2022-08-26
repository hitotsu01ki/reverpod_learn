import 'package:hooks_riverpod/hooks_riverpod.dart';

final dateTimeUtilsProvider = Provider<DateTimeUtils>((_) => DateTimeUtils());

class DateTimeUtils {

  DateTime now() {
    return DateTime.now();
  }

  DateTime nowMinute() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, now.hour, now.minute);
  }

  List<String> weekdayListJp = ['日', '月', '火', '水', '木', '金', '土', '日', ];

  String yyyymmddToString(DateTime d) {
    String s = '${d.year}年${d.month}月${d.day}日(${weekdayListJp[d.weekday]})';
    return s;
  }

  String yyyymmddhhmmssToString(DateTime d) { // 2022-01-02 03:04:00
    String s = '${d.year}-${len02(d.month)}-${len02(d.day)} ${len02(d.hour)}:${len02(d.minute)}:00';
    return s;
  }

  DateTime? yyyymmddhhmmssToDateTime(String s) { // 2022-01-02 03:04:00
    try {
      if (s.length == 19) {
        int yyyy = int.parse(s.substring(0, 4)); // 2022
        int mm = int.parse(s.substring(5, 7)); // 01
        int dd = int.parse(s.substring(8, 10)); // 02
        int hh = int.parse(s.substring(11, 13)); // 03
        int mi = int.parse(s.substring(14, 16)); // 04

        return DateTime(yyyy, mm, dd, hh, mi);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  String len02(int i) { // int 2 -> String '02'
    if (i < 10) {
      return '0$i';
    } else {
      return '$i';
    }
  }

}