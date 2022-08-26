import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/phone_size_provider.dart';

class DatePickerWidget extends HookConsumerWidget {
  const DatePickerWidget({this.initialDateTime, required this.onDateTimeChanged, this.height = 80, Key? key}) : super(key: key);
  final DateTime? initialDateTime;
  final Function(DateTime) onDateTimeChanged;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final _size = ref.watch(phoneSizeProvider);
    final log = ref.watch(debugLogPrintProvider);

    return SizedBox(
      height: height,
      child: CupertinoDatePicker(
        initialDateTime: initialDateTime,
        onDateTimeChanged: onDateTimeChanged,
        mode: CupertinoDatePickerMode.time,
        use24hFormat: false,
      ),
    );
  }
}
