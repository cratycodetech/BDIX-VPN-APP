import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart'; // Import GetX
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'controllers/openvpn_controller.dart';
import 'routes/routes.dart'; // Import your routes file

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();
  final openVpnController = Get.put(OpenVPNController());
  await openVpnController.init();
  runApp(const ProviderScope( // Wrap your app with ProviderScope
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844), // Design width and height for responsiveness
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: AppRoutes.splash,
          getPages: AppRoutes.routes,
          unknownRoute: GetPage(
            name: '/not-found',
            page: () => const Scaffold(
              body: Center(
                child: Text('Page not found'),
              ),
            ),
          ),
        );
      },
    );
  }
}
