import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/openvpn_controller.dart';


void showSignUpDialog(BuildContext context) async {

  final vpnController = Get.find<OpenVPNController>();

  final result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Up Required'),
        content: const Text('To continue using the app, please sign up.'),
        actions: [
          TextButton(
            onPressed: () {
              vpnController.disconnect();
              Navigator.pop(context, true);
              Get.toNamed('/signIn');
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );

  if (result == null) {
    vpnController.disconnect();
    Get.toNamed('/signIn');
  }
}

