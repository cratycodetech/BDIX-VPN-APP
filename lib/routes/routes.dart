import 'package:get/get.dart';
import '../presentation/forgot_password/forgot_password.dart';
import '../presentation/forgot_password/forgot_password2.dart';
import '../presentation/home_screen/normal_home_screen.dart';
import '../presentation/one_time_splash_screen/one_time_splash_screen.dart';
import '../presentation/sign_in_screen/sign_in_screen.dart';
import '../presentation/sign_up_screen/signUp_otp_screen.dart';
import '../presentation/sign_up_screen/signUp_passWord_screen.dart';
import '../presentation/sign_up_screen/sign_up_screen1.dart';
import '../presentation/welcome_screen/welcome_screen.dart';
import '../presentation/home_screen/normal_home_connect_screen.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';
import '../controllers/openvpn_controller.dart';

class AppRoutes {
  // Route names
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const signIn = '/signIn';
  static const forgotPassword = '/forgotPassword';
  static const forgotPassword2 = '/forgotPassword2';
  static const signUp1 = '/signUp1';
  static const signUpOTP = '/signUpOTP';
  static const signUpPass = '/signUpPass';
  static const guestHome = '/guestHome';
  static const normalConnectHome = '/normalConnectHome';

  static final routes = [
    GetPage(name: splash, page: () => OneTimeSplashScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: signIn, page: () => SignInScreen()),
    GetPage(name: forgotPassword, page: () => ForgetPasswordApp()),
    GetPage(name: forgotPassword2, page: () => ResetPasswordApp()),
    GetPage(name: signUp1, page: () => SignUpApp()),
    GetPage(name: signUpOTP, page: () => SignUp3()),
    GetPage(name: signUpPass, page: () => SignUp6()),
    GetPage(name: guestHome, page: () => const GuestHome()),
    GetPage(
      name: normalConnectHome,
      page: () {
        final engine = Get.find<OpenVPNController>().engine;
        if (engine == null) {
          // Fallback behavior if engine is not initialized
          Get.snackbar(
            'Error',
            'VPN engine not initialized. Redirecting to GuestHome.',
          );
          return const GuestHome();
        }
        return GuestHomeScreen(engine: engine);
      },
    ),
  ];
}
