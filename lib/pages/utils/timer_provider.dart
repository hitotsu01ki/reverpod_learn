import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';


final timerProvider = Provider((_) {
  Timer? timer;
  return TimerClass(timer);
});

class TimerClass {
  TimerClass(this.timer);

  Timer? timer;

  Timer? get getTimer => timer;
  set setTimer(Timer time) => timer = time;
  void disposeTimer() => timer!.cancel();
}
