// lib/providers/timer_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';

class TimerProvider with ChangeNotifier {
  Timer? _timer;
  int _timeLeft = 0;

  int get timeLeft => _timeLeft;
  bool get isRunning => _timer != null;

  void startTimer(int initialTime) {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timeLeft = initialTime;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        _timeLeft--;
        notifyListeners();
      } else {
        _timer?.cancel();
      }
    });
  }

  void pauseTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resumeTimer() {
    if (_timeLeft > 0 && _timer == null) {
      startTimer(_timeLeft);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
