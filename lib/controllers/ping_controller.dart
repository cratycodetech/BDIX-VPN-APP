import 'package:get/get.dart';
import 'package:dart_ping/dart_ping.dart';

class PingController extends GetxController {
  var usaPing = ''.obs;
  var indiaPing = ''.obs;
  var finlandPing = ''.obs;
  var singaporePing = ''.obs;

  void startPing() async {
    final countries = {
      'USA': '5.161.66.241',
      'India': '148.113.45.41',
      'Finland': '37.27.209.38',
      'Singapore': '5.223.50.93',
    };

    for (var country in countries.keys) {
      final ip = countries[country];
      final ping = Ping(ip!, count: 1);

      ping.stream.listen((event) {
        final regex = RegExp(r'time:([\d.]+)\sms');
        final match = regex.firstMatch(event.toString());

        if (match != null) {
          final time = match.group(1);

          if (country == 'USA') {
            usaPing.value = '$time ms';
          } else if (country == 'India') {
            indiaPing.value = '$time ms';
          } else if (country == 'Finland') {
            finlandPing.value = '$time ms';
          } else if (country == 'Singapore') {
            singaporePing.value = '$time ms';
          }
        }
      });
    }
  }
}
