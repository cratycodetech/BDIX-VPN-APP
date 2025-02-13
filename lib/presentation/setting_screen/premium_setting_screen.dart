import 'package:bdix_vpn/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/openvpn_controller.dart';
import '../../models/user_preferences.dart';
import '../../routes/routes.dart';
import '../../service/api/auth_service.dart';
import '../../service/database/database_helper.dart';
import '../../service/device_service.dart';
import '../../service/notification_service.dart';
import '../../utils/scaffold_messenger_utils.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/disconnect_dialog_box.dart';
import '../sign_in_screen/sign_in_screen.dart';
import '../sign_up_screen/sign_up_screen1.dart';

class PremiumSettingScreen extends StatefulWidget {
  const PremiumSettingScreen({super.key});

  @override
  State<PremiumSettingScreen> createState() => _PremiumSettingScreenState();
}

class _PremiumSettingScreenState extends State<PremiumSettingScreen> {
  int? _selectedValue = 0;
  late int _currentIndex = 3;
  final UserService _userService = UserService();
  final DeviceService _deviceService = DeviceService();
  final AuthService _authService = AuthService();
  final DeviceService deviceService = DeviceService();
  final OpenVPNController vpnController = Get.find<OpenVPNController>();
  bool _isKillSwitchToggled = false;
  bool _isConnectOnStartToggled = false;
  bool _isShowNotificationToggled = false;
  bool isGuest = false;
  bool _isLoggingOut = false;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _toggleSwitch(int switchType, bool value) async {
    if (switchType == 2 && value) {
      // If user is enabling notifications, request permission
      bool isGranted = await NotificationService.requestPermissions();

      if (!isGranted) {
        // If permission is denied, do not update the state
        showScaffoldMessage(context, "Notification permission is required to enable this feature.");
        return;
      }
    }

    // Proceed to update the state
    setState(() {
      switch (switchType) {
        case 0:
          _isKillSwitchToggled = value;
          break;
        case 1:
          _isConnectOnStartToggled = value;
          break;
        case 2:
          _isShowNotificationToggled = value;
          break;
      }
      _savePreferences();
    });
  }


  void _savePreferences() async {
    final userId = await _userService.getUserId();
    if (userId == null) {
      throw Exception("User ID cannot be null");
    }

    UserPreferences preferences = UserPreferences(
      userID: userId,
      openVPN: _selectedValue == 1,
      ipSec: _selectedValue == 0,
      issr: _selectedValue == 2,
      blockInternet: _isKillSwitchToggled,
      connectOnStart: _isConnectOnStartToggled,
      showNotification: _isShowNotificationToggled,
    );
    UserPreferences? existingPreferences =
        await DatabaseHelper().getUserPreferences(userId);

    if (existingPreferences != null) {
      await DatabaseHelper().updateUserPreferences(preferences);
      debugPrint("Updating existing user preferences for user ID: $userId");
    } else {
      debugPrint("Inserting new user preferences for user ID: $userId");
      await DatabaseHelper().insertUserPreferences(preferences);
    }
  }

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
      _savePreferences();
    });
  }

  void _loadPreferences() async {
    final userId = await _userService.getUserId();
    if (userId != null) {
      UserPreferences? preferences =
          await DatabaseHelper().getUserPreferences(userId);
      if (preferences != null) {
        setState(() {
          _selectedValue =
              preferences.ipSec ? 0 : (preferences.openVPN ? 1 : 2);
          _isKillSwitchToggled = preferences.blockInternet;
          _isConnectOnStartToggled = preferences.connectOnStart;
          _isShowNotificationToggled = preferences.showNotification;
        });
      }
    }
  }

  Future<void> _logoutForGuest(BuildContext context, bool isForSignup)async {
    if (vpnController.isConnected.value) {
      final shouldDisconnect = await showDialog<bool>(
        context: context,
        builder: (context) => const DisconnectDialog(),
      );

      if (shouldDisconnect == true) {
        deviceService.removeDeviceId();
        if(isForSignup)
          {
            Get.offAll(const SignUpScreen());
          }else{
          Get.offAll(SignInScreen());
        }
      }
    }else{
      deviceService.removeDeviceId();
      if(isForSignup)
      {
        Get.offAll(const SignUpScreen());
      }else{
        Get.offAll(SignInScreen());
      }
    }
  }

  Future<void> _logout(BuildContext context) async {
    if (_isLoggingOut) return;

    if (vpnController.isConnected.value) {
      final shouldDisconnect = await showDialog<bool>(
        context: context,
        builder: (context) => const DisconnectDialog(),
      );

      if (shouldDisconnect == true) {
        setState(() {
          _isLoggingOut = true;
        });
        try {
          await _userService.removeUserType();
          await _authService.logout();
          Get.toNamed(AppRoutes.signIn);
        } catch (e) {
          Get.snackbar(
            'Error',
            'Logout failed. Please try again.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      }
    } else {
      setState(() {
        _isLoggingOut = true;
      });
      try {
        await _userService.removeUserType();
        await _authService.logout();
        Get.toNamed(AppRoutes.signIn);
      } catch (e) {
        Get.snackbar(
          'Error',
          'Logout failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPreferences();
    _checkGuestStatus();

  }

  void _checkGuestStatus() async {
    bool guestStatus = await _deviceService.checkGuestStatus();
    setState(() {
      isGuest = guestStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 73,
            ),
            const Text(
              'Connection Mode',
              style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFFDBD2D1),
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                const Text(
                  'OpenVPN',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const Spacer(),
                Radio<int>(
                  value: 1,
                  groupValue: 1,
                  onChanged: _handleRadioValueChange,
                ),
              ],
            ),
            // Row(
            //   children: [
            //     const Text(
            //       'IPSec',
            //       style: TextStyle(fontSize: 18, color: Colors.black),
            //     ),
            //     const Spacer(),
            //     Radio<int>(
            //       value: 0,
            //       groupValue: _selectedValue,
            //       onChanged: _handleRadioValueChange,
            //     ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 1,
            // ),
            // Row(
            //   children: [
            //     const Text(
            //       'ISSR',
            //       style: TextStyle(fontSize: 18, color: Colors.black),
            //     ),
            //     const Spacer(),
            //     Radio<int>(
            //       value: 1,
            //       groupValue: _selectedValue,
            //       onChanged: _handleRadioValueChange,
            //     ),
            //   ],
            // ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: SizedBox(
                width: 420,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0, left: 8),
                  child: Divider(
                    color: Color(0xFFDBD2D1),
                    thickness: 1,
                  ),
                ),
              ),
            ),
            const Row(
              children: [
                Text(
                  'Kill Switch',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFDBD2D1),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Block internet when connecting or \nchanging servers',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                      value: _isKillSwitchToggled,
                      onChanged: (value) => _toggleSwitch(0, value)),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: SizedBox(
                width: 420,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0, left: 8),
                  child: Divider(
                    color: Color(0xFFDBD2D1),
                    thickness: 1,
                  ),
                ),
              ),
            ),
            const Row(
              children: [
                Text(
                  'Connection',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFDBD2D1),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Text(
                  'Connect when Prime VPN starts',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                      value: _isConnectOnStartToggled,
                      onChanged: (value) => _toggleSwitch(1, value)),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const Center(
              child: SizedBox(
                width: 420,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0, left: 8),
                  child: Divider(
                    color: Color(0xFFDBD2D1),
                    thickness: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Row(
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFDBD2D1),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(
                  width: 15,
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Show notification when Prime VPN is not connected ',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                      value: _isShowNotificationToggled,
                      onChanged: (value) => _toggleSwitch(2, value)),
                ),
                const SizedBox(
                  width: 8,
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            const Center(
              child: SizedBox(
                width: 420,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.0, left: 8),
                  child: Divider(
                    color: Color(0xFFDBD2D1),
                    thickness: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            if (!isGuest) ...[
              const Text(
                'Account',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFDBD2D1),
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  const Text(
                    'Logout',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  const Spacer(),
                  const SizedBox(
                    height: 44,
                  ),
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () => _logout(context),
                  ),
                  const SizedBox(
                    width: 16,
                  )
                ],
              ),
            ],
            if (isGuest) ...[
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Sign In Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _logoutForGuest(context, false),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF393E7A),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Color(0xFFE6E7EE),
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Sign Up Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _logoutForGuest(context, true),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF080E59)),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF080E59),
                            fontSize: 16,
                            fontFamily: 'Nunito',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
