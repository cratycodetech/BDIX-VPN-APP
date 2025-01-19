import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../presentation/welcome_screen/welcome_screen.dart';
import '../service/api/auth_service.dart';
import '../service/device_service.dart';
import '../utils/scaffold_messenger_utils.dart';


void showSignUpDialog(BuildContext context,bool timeOver ) async {

  final DeviceService deviceService = DeviceService();

  final result = await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign Up Required'),
        content: const Text('To continue using the app, please sign up.'),
        actions: [
          TextButton(
            onPressed: () async {
              if(timeOver){
                DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
                AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

                String? deviceId = androidInfo.id; // Fetch unique device ID

                if (deviceId != null) {
                  print('Device ID: $deviceId'); // Log or use it as needed

                  // Show loading indicator
                  showDialog(
                    context: context,
                    barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );

                  try {
                    // Call guestUser method
                    await AuthService().guestUser(deviceId: deviceId);
                    showScaffoldMessage(context, "Guest access finished, please sign up to continue.");
                    Navigator.pop(context, true);
                    Get.offAll(WelcomeScreen());
                  } catch (e) {
                    showScaffoldMessage(context, "Guest access finished, please sign up to continue.");
                    Navigator.pop(context, true);
                    deviceService.removeDeviceId();
                    Get.offAll(WelcomeScreen());

                  }
                } else {
                  print('Failed to retrieve device ID');
                }
              }
              else{
                Navigator.pop(context, true);
                showScaffoldMessage(context, "You have to signup first to be premium user");
              }

            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );

  if (result == null) {
    if(timeOver){

      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      String? deviceId = androidInfo.id; // Fetch unique device ID

      if (deviceId != null) {
        print('Device ID: $deviceId'); // Log or use it as needed

        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false, // Prevent dismissing the dialog by tapping outside
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        try {
          // Call guestUser method
          await AuthService().guestUser(deviceId: deviceId);
          showScaffoldMessage(context, "Free guest access finished, you will see frequent ad, for ad free experience try sign in");
          Navigator.pop(context, true);
          Get.offAll(WelcomeScreen());
        } catch (e) {
          showScaffoldMessage(context, "Free guest access finished, you will see frequent ad, for ad free experience try sign in");
          Navigator.pop(context, true);
          deviceService.removeDeviceId();
          Get.offAll(WelcomeScreen());

        }
      } else {
        print('Failed to retrieve device ID');
      }
    }


  }
}

