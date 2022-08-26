import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/utils/date_time_utils_provider.dart';
import 'package:riverpod_app/pages/utils/phone_size_provider.dart';

final utilsProvider = Provider((_) {
  return Utils(_.read);
});

class Utils {
  Utils(this._reader);
  final Reader _reader;

  late final Size _size = _reader(phoneSizeProvider);
  Size get size => _size;

  late final DateTimeUtils _dateTimeUtils = _reader(dateTimeUtilsProvider);
  DateTime get now => _dateTimeUtils.now();
  DateTime get nowMinute => _dateTimeUtils.nowMinute();

  double calcMargin(double maxWidthPx, double widgetWidthPx) {
    return _size.width * (1 - (widgetWidthPx / maxWidthPx)) / 2;
  }

}
