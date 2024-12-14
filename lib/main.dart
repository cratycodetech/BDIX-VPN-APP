import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import GetX
import 'presentation/one_time_splash_screen/one_time_splash_screen.dart';
import 'routes/routes.dart'; // Import your routes file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.guestHomeScreen, // Set the initial route
      getPages: AppRoutes.routes,    // Define all routes
    );
  }
}
