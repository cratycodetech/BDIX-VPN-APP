import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';
import '../../service/auth_service.dart';
import '../../service/user_service.dart';
import '../../widgets/bottomNavigationBar_widget.dart';

class GuestSettingScreen extends StatefulWidget {
  const GuestSettingScreen({super.key});

  @override
  State<GuestSettingScreen> createState() => _GuestSettingScreenState();
}

class _GuestSettingScreenState extends State<GuestSettingScreen> {
  int? _selectedValue = 0;
  bool _isToggled = false;
  late int _currentIndex = 0;
  final AuthService _authService = AuthService();
  bool isGuest = false;
  final UserService _userService = UserService();

  @override
  void initState() {
    super.initState();
    _checkGuestStatus();
  }


  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });
  }

  Future<void> _logout() async {
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

  Future<void> _checkGuestStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? deviceId = prefs.getString('guest_device_id');

    if (deviceId != null) {
      setState(() {
        isGuest = true; // User is a guest, hide the logout button
      });
    } else {
      setState(() {
        isGuest = false; // User is not a guest, show the logout button
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 73.h),
            Text(
              'Connection Mode',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFDBD2D1),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Text(
                  'OpenVPN',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                const Spacer(),
                Radio<int>(
                  value: 0,
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
              ],
            ),
            Center(
              child: SizedBox(
                width: 420.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.w, left: 8.w),
                  child: Divider(
                    color: const Color(0xFFDBD2D1),
                    thickness: 1.h,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Kill Switch',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFFDBD2D1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/crown.svg',
                  height: 15.h,
                  width: 16.67.w,
                ),
                SizedBox(width: 15.w),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  'Block internet when connecting or \nchanging servers',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                    value: _isToggled,
                    onChanged: (bool value) {
                      setState(() {
                        _isToggled = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
            SizedBox(height: 8.h),
            Center(
              child: SizedBox(
                width: 420.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.w, left: 8.w),
                  child: Divider(
                    color: const Color(0xFFDBD2D1),
                    thickness: 1.h,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Text(
                  'Connection',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFFDBD2D1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/crown.svg',
                  height: 15.h,
                  width: 16.67.w,
                ),
                SizedBox(width: 15.w),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  'Connect when Prime VPN \nstarts',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                    value: _isToggled,
                    onChanged: (bool value) {
                      setState(() {
                        _isToggled = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
            Row(
              children: [
                Text(
                  'Connection duration boost',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                    value: _isToggled,
                    onChanged: (bool value) {
                      setState(() {
                        _isToggled = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),
            SizedBox(height: 29.h),
            Center(
              child: SizedBox(
                width: 420.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.w, left: 8.w),
                  child: Divider(
                    color: const Color(0xFFDBD2D1),
                    thickness: 1.h,
                  ),
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                Text(
                  'Notification',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFFDBD2D1),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/crown.svg',
                  height: 15.h,
                  width: 16.67.w,
                ),
                SizedBox(width: 15.w),
              ],
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Flexible(
                  child: Text(
                    'Show notification when Prime VPN is not connected ',
                    style: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ),
                const Spacer(),
                Transform.scale(
                  scale: 0.8, // Adjust the scale factor to resize the Switch
                  child: Switch(
                    value: _isToggled,
                    onChanged: (bool value) {
                      setState(() {
                        _isToggled = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ),

            Center(
              child: SizedBox(
                width: 420.w,
                child: Padding(
                  padding: EdgeInsets.only(right: 24.w, left: 8.w),
                  child: Divider(
                    color: const Color(0xFFDBD2D1),
                    thickness: 1.h,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            if (!isGuest)
            Text(
              'Account',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFFDBD2D1),
                fontWeight: FontWeight.bold,
              ),
            ),
            //if (!isGuest)
            Row(
              children: [
                Text(
                  'Logout',
                  style: TextStyle(fontSize: 18.sp, color: Colors.black),
                ),
                const Spacer(),
                SizedBox(height: 44.h),
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: _logout ,
                ),
              ],
            ),
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
