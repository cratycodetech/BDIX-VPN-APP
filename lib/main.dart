import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'controllers/openvpn_controller.dart'; // Import the OpenVPNController
import 'presentation/one_time_splash_screen/one_time_splash_screen.dart';
import 'routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Register OpenVPNController globally
  final openVpnController = Get.put(OpenVPNController());
  await openVpnController.init(); // Initialize the OpenVPN engine

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'BDX VPN',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.guestHome,
          getPages: AppRoutes.routes,
        );
      },
    );
  }
}
