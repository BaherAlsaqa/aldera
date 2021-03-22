import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  int minutes = 2;
  int second = 0;
  Timer _timer;

  changeSecond() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (minutes > 0) {
        if (second > 0) {
          second--;
        } else {
          if (minutes != 0) {
            minutes--;
          }
          second = 60;
        }
      } else {
        if (second > 0) {
          second--;
        } else {
          _timer.cancel();
        }
      }
      notifyListeners();
    });
  }

  cancelTimer() {
    _timer.cancel();
    notifyListeners();
  }
}
