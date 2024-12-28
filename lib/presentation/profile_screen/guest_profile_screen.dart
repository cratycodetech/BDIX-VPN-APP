import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/bottomNavigationBar_widget.dart';

class GuestProfileScreen extends StatefulWidget {
  const GuestProfileScreen({super.key});

  @override
  State<GuestProfileScreen> createState() => _GuestProfileScreenState();
}

class _GuestProfileScreenState extends State<GuestProfileScreen> {
  late int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 150.h,
          ),
          Center(
            child: Container(
              width: 226.w,
              height: 210.h,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/searching_image.png'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 225.71.w,
            child: Transform.translate(
              offset: Offset(0, -8.h), // Move the divider 3 pixels up
              child: Divider(
                color: const Color(0xFFDBD2D1),
                thickness: 1.h,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            'Looks like you are not signed in yet',
            style: TextStyle(
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              letterSpacing: -0.02,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 90.w, // Button width
            height: 36.h, // Button height
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1D1D7D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.r),
                ),
              ),
              onPressed: () {},
              child: Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50.h,
          ),
          Row(
            children: [
              SizedBox(width: 32.w),
              Text(
                'ID',
                style: TextStyle(
                  color: const Color(0xFF080E59),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 60.w),
              Text(
                '284529462',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(), // This will push the checkbox to the far right
              SizedBox(
                width: 32.w,
                child: Checkbox(
                  value: false, // If you want the checkbox to be unchecked initially
                  onChanged: null, // Add functionality if needed
                ),
              ),
              SizedBox(width: 32.w),
            ],
          ),
          Row(
            children: [
              SizedBox(width: 32.w),
              SvgPicture.asset(
                'assets/images/crown.svg',
                height: 15.h,
                width: 16.67.w,
              ),
              SizedBox(width: 32.w),
              Text(
                'Base Plan',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 70.w,
                height: 25.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF1D1D7D),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {},
                  child: Text(
                    'Guest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 42.w),
            ],
          )
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
