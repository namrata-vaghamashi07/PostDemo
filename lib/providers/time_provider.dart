// lib/providers/timer_provider.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_demo/models/timer_data.dart';

class TimerProvider with ChangeNotifier {
  final Map<int, TimerData> _timers = {}; // Stores timers by ID

  Map<int, TimerData> get timers => _timers;

  // Start a timer for a specific item
  void startTimer(int id, int initialTime) {
    if (_timers.containsKey(id)) {
      _timers[id]?.timer?.cancel();
    }

    final timerData = TimerData(
      timer: Timer.periodic(const Duration(seconds: 1), (timer) {
        if ((_timers[id]?.timeLeft ?? 0) > 0) {
          _timers[id]!.timeLeft--;
          notifyListeners();
        } else {
          timer.cancel();
          _timers.remove(id);
          notifyListeners();
        }
      }),
      timeLeft: initialTime,
    );

    _timers[id] = timerData;
    notifyListeners();
  }

  // Pause the timer for a specific item
  void pauseTimer(int id) {
    if (_timers.containsKey(id)) {
      _timers[id]?.timer?.cancel();
      _timers[id]?.timer = null;
      notifyListeners();
    }
  }

  // Resume the timer for a specific item
  void resumeTimer(int id) {
    if (_timers.containsKey(id) && _timers[id]?.timer == null) {
      startTimer(id, _timers[id]!.timeLeft);
    }
  }

  @override
  void dispose() {
    _timers.forEach((_, timerData) => timerData.timer?.cancel());
    super.dispose();
  }
}
