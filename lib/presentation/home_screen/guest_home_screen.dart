import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/bottomNavigationBar_widget.dart';

class GuestHomeScreen extends StatefulWidget {
  const GuestHomeScreen({super.key});

  @override
  State<GuestHomeScreen> createState() => _GuestHomeScreenState();
}

class _GuestHomeScreenState extends State<GuestHomeScreen> {
  late int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              SizedBox(height: 50.h),
              Row(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 32.w,
                    height: 32.h,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    'BDX VPN',
                    style: TextStyle(
                        fontSize: 14.sp, color: const Color(0xFF393E7A)),
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.translate(
                    offset: Offset(0, -70.h),
                    child: Image.asset(
                      'assets/images/map.png',
                      width: double.infinity,
                      height: 400.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(-100.w, -85.h),
                    child: SvgPicture.asset(
                      'assets/images/location_icon.svg',
                      width: 14.w,
                      height: 18.h,
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0, -170.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Status : ',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    Text(
                      'Connected',
                      style: TextStyle(
                          fontSize: 12.sp, color: const Color(0xFFD77704)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Transform.translate(
                offset: Offset(0, -170.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/globe_icon.svg',
                            width: 38.w,
                            height: 38.h,
                          ),
                          SizedBox(width: 12.w),
                          Text(
                            'Smart Location',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: const Color(0xFF545454)),
                          ),
                          const Spacer(),
                          CircleAvatar(
                            radius: 7.w,
                            backgroundColor: const Color(0xFF393E7A),
                            child: Icon(
                              Icons.done,
                              size: 10.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 1.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/custom_down_arrow.svg',
                                width: 14.w,
                                height: 18.h,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '28.5',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'KB/S',
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/custom_up_arrow.svg',
                                width: 14.w,
                                height: 18.h,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                '28.5',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                'KB/S',
                                style: TextStyle(
                                    fontSize: 12.sp, color: Colors.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Transform.translate(
                offset: Offset(0, -170.h),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF6F6F6),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Remaining Time',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF545454)),
                          ),
                          const Spacer(),
                          Text(
                            '00:25:21',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEC8304),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Text(
                                '+Random Time',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color(0xFFFDF3E6),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                    color: const Color(0xFFEC8304),
                                    width: 1.0.w),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Go Pro',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: const Color(0xFFEC8304),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  SvgPicture.asset(
                                    'assets/images/crown.svg',
                                    height: 10.h,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //SizedBox(height: 16.h),
              Transform.translate(
                offset: Offset(0, -130.h),
                child: SvgPicture.asset(
                  'assets/images/tap_button.svg',
                  width: 50.w,
                  height: 50.h,
                ),
              ),
              Transform.translate(
                offset: Offset(0, -130.h),
                child: Text(
                'Tap to Disconnect',
                style: TextStyle(
                    fontSize: 28.sp,
                    color: const Color(0xFF393E7A),
                    fontWeight: FontWeight.bold),
              ),
        )
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
