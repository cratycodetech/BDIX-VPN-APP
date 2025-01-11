import 'dart:async';
import 'package:bdix_vpn/presentation/connection_screen/connection_failed_screen.dart';
import 'package:bdix_vpn/service/connectivity_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/openvpn_controller.dart';
import 'routes/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();

  final openVpnController = Get.put(OpenVPNController());
  await openVpnController.init();
  final connectivityService = Get.put(ConnectivityService());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }
  runApp(ProviderScope(
    child: MyApp(
      connectivityService: connectivityService,
      initialRoute: isFirstLaunch ? AppRoutes.splash : AppRoutes.welcome,
    ),
  ));
}

class MyApp extends StatefulWidget {
  final ConnectivityService connectivityService;
  final String initialRoute;
  const MyApp(
      {super.key,
      required this.connectivityService,
      required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return StreamBuilder<bool>(
          stream: widget.connectivityService.connectivityStream,
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.data!) {
              return GetMaterialApp(
                home: const ConnectionFailedScreen(),
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                  colorScheme:
                      ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
              );
            }
            final OpenVPNController vpnController =
                Get.find<OpenVPNController>();
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              initialRoute: vpnController.isConnected.value
                  ? AppRoutes.guestHomeScreen
                  : widget.initialRoute,
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
      },
    );
  }
}
