import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimerNotifier extends StateNotifier<int> {
  TimerNotifier() : super(3600);

  Timer? _timer;
  bool _adTriggered = false;
  bool _adShownForSession = false;
  bool _dialogTriggered = false;
  bool _normalDialogTriggered = false;


  bool get shouldShowAd => !_adTriggered && state == 359 && !_adShownForSession;
  bool get signUpDialogShow => _dialogTriggered;
  bool get normalSignUpDialogShow => _normalDialogTriggered;


  void startTimer() {
    if (_timer != null) return;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state -= 1;

        // Check for ad trigger
        if (state == 359 && !_adTriggered && !_adShownForSession) {
          _adTriggered = true;
          _adShownForSession = true;
        }
      } else {
        _timer?.cancel();
      }

      if (state == 359 && !_dialogTriggered) {
        _dialogTriggered = true;
      }

      if (state == 358 && !_normalDialogTriggered) {
        _normalDialogTriggered  = true;
      }

    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void addExtraTime(int seconds) {
    state += seconds;
  }


  void resetAdFlag() {
    _adShownForSession = false;
    _adTriggered = false;
    _dialogTriggered = false;
    _normalDialogTriggered = false;
  }

  void stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void resetTimer() {
    stopTimer();
    state = 3600;
  }
}

final timerProvider = StateNotifierProvider<TimerNotifier, int>((ref) {
  return TimerNotifier();
});