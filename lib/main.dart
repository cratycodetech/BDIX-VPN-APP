import 'dart:async';
import 'package:bdix_vpn/presentation/connection_screen/connection_failed_screen.dart';
import 'package:bdix_vpn/service/background/timer_background_service.dart';
import 'package:bdix_vpn/service/connectivity_service.dart';
import 'package:bdix_vpn/service/notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'controllers/country_controller.dart';
import 'controllers/openvpn_controller.dart';
import 'routes/routes.dart';
import 'package:workmanager/workmanager.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📩 Background Message Received: ${message.notification?.title}");
}

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  String? fcmtoken = await messaging.getToken();
  if (fcmtoken != null) {
    print("🔥 FCM Token: $fcmtoken");
  } else {
    print("❌ Failed to retrieve FCM token.");
  }


  NotificationService.initialize((String? payload) {
    if (payload == "open_page") {
      Get.offNamed(
        AppRoutes.guestHome,
      );
    }
  });
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  final openVpnController = Get.put(OpenVPNController());
  await openVpnController.init();
  final connectivityService = Get.put(ConnectivityService());

  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;
  if (isFirstLaunch) {
    await prefs.setBool('isFirstLaunch', false);
  }

  final token = prefs.getString('accessToken');

  final deviceId = prefs.getString('guest_device_id');

  String initialRoute;
  if (isFirstLaunch) {
    initialRoute = AppRoutes.splash;
  } else if (token != null || deviceId != null) {
    initialRoute = AppRoutes.guestHome;
  } else {
    initialRoute = AppRoutes.welcome;
  }
  Get.put(CountryController());
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(
    ProviderScope(
      child: MyApp(
        connectivityService: connectivityService,
        initialRoute: initialRoute,
      ),
    ),
  );


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
  void initState() {
    super.initState();

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("📩 Notification Clicked While App was in Background!");
      print("Title: ${message.notification?.title}");
      print("Body: ${message.notification?.body}");


      if (message.data.containsKey('screen')) {
        Get.toNamed(message.data['screen']);
      } else {
        Get.toNamed(AppRoutes.guestHome);
      }
    });

    NotificationService().handleForegroundMessages();
    NotificationService().checkInitialMessage();
  }

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
