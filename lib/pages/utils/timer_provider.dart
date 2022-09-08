import 'dart:async';

import 'package:hooks_riverpod/hooks_riverpod.dart';


final timerProvider = Provider((_) {
  Timer? timer;
  return TimerClass(timer);
});

final timerProvider2 = Provider((_) {
  Timer? timer;
  return TimerClass(timer);
});

final timerProvider3 = Provider((_) {
  Timer? timer;
  return TimerClass(timer);
});

final timerProvider4 = Provider((_) {
  Timer? timer;
  return TimerClass(timer);
});

final timerFamily = Provider.family((_, Timer? timer) {
  return TimerClass(timer);
});

class TimerClass {
  TimerClass(this.timer);

  Timer? timer;

  Timer? get getTimer => timer;
  set setTimer(Timer time) => timer = time;
  void disposeTimer() => timer!.cancel();

  void addTimerListener(Function(Timer) func, Duration duration) {
    if (timer != null) {
      if (timer!.isActive) {
        return;
      }
    }
    setTimer = Timer.periodic(duration, func,);
  }
}
