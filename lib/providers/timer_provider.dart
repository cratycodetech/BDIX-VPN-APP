import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(3600);

  Timer? _timer;
  bool _adTriggered = false;
  bool _adShownForSession = false;  // Flag to track if the ad has been shown for this session

  bool get shouldShowAd => !_adTriggered && state == 35900 && !_adShownForSession; // Show ad after 10 seconds if not shown in this session

  void startTimer() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state -= 1;

        // Check for ad trigger
        if (state == 3590 && !_adTriggered && !_adShownForSession) {
          _adTriggered = true;
          _adShownForSession = true;  // Mark that the ad has been shown for this session
        }
      } else {
        _timer?.cancel();
      }
    });
  }

  // Dispose of the timer
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void addExtraTime(int seconds) {
    state += seconds; // Add the specified seconds to the current state
  }

  // Reset session ad flag (if needed to track across multiple app restarts)
  void resetAdFlag() {
    _adShownForSession = false;
    _adTriggered = false;
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});
