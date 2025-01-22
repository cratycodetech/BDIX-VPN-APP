import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<void> connectVPN() async {

  final appDocDir = await getApplicationDocumentsDirectory();
  final vpnExecutablePath = '${appDocDir.path}/ovpnconnector.exe';


  final byteData = await rootBundle.load('assets/windows/ovpnconnector.exe');
  final buffer = byteData.buffer.asUint8List();


  final file = File(vpnExecutablePath);
  await file.writeAsBytes(buffer);


  final vpnConfigPath = '${appDocDir.path}/client1.ovpn';
  final result = await Process.run(vpnExecutablePath, ['--config', vpnConfigPath]);

  if (result.exitCode == 0) {
    print('VPN connected successfully');
  } else {
    print('Failed to connect VPN');
  }
}
