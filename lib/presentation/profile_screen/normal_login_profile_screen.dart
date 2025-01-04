import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/user.dart';
import '../../service/api/user_remote_service.dart';
import '../../widgets/bottomNavigationBar_widget.dart';

class NormalLoginProfileScreen extends StatefulWidget {
  const NormalLoginProfileScreen({super.key});

  @override
  State<NormalLoginProfileScreen> createState() => _NormalLoginProfileScreenState();
}

class _NormalLoginProfileScreenState extends State<NormalLoginProfileScreen> {
  late int _currentIndex = 0;
  late Future<User> _userFuture;

  @override
  void initState() {
    super.initState();
    _userFuture = UserRemoteService().userDetails();
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(16.0.w),  // Using ScreenUtil to scale padding
        child: FutureBuilder<User>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No user data found.'));
            }

            final user = snapshot.data!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h), // Scale height
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    const Text(
                      'ID',
                      style: TextStyle(
                          color: Color(0xFF080E59),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      user.userId.toString(), // Displaying fetched user ID
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SvgPicture.asset(
                      'assets/images/pencil.svg',
                      height: 15.h, // Scale height
                      width: 16.67.w, // Scale width
                    ),
                    const Checkbox(
                      value: false,
                      onChanged: null,
                    ),
                  ],
                ),
                Divider(
                  color: const Color(0x80DAD9DB),
                  thickness: 1.w, // Scale thickness
                ),
                Row(
                  children: [
                    const Text(
                      'EMAIL',
                      style: TextStyle(
                          color: Color(0xFF080E59),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      user.email.length > 15
                          ? '${user.email.substring(0, 15)}...'  // Truncate email to 20 characters and add "..."
                          : user.email, // Show the full email if it's short
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    SizedBox(width: 60.w), // Scale width
                    SvgPicture.asset(
                      'assets/images/pencil.svg',
                      height: 15.h, // Scale height
                      width: 16.67.w, // Scale width
                    ),
                    const Checkbox(
                      value: false,
                      onChanged: null,
                    ),
                  ],
                ),
                Divider(
                  color: const Color(0x80DAD9DB),
                  thickness: 1.w, // Scale thickness
                ),
                Row(
                  children: [
                    const Text(
                      'PASSWORD',
                      style: TextStyle(
                          color: Color(0xFF080E59),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      user.password.length > 15
                          ? '${user.password.substring(0, 15)}...'  // Truncate email to 20 characters and add "..."
                          : user.password,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SizedBox(width: 70.w), // Scale width
                    SvgPicture.asset(
                      'assets/images/pencil.svg',
                      height: 15.h, // Scale height
                      width: 16.67.w, // Scale width
                    ),
                    const Checkbox(
                      value: false,
                      onChanged: null,
                    ),
                  ],
                ),
                Divider(
                  color: const Color(0x80DAD9DB),
                  thickness: 1.w, // Scale thickness
                ),
                Row(
                  children: [
                    const Text(
                      'VPN',
                      style: TextStyle(
                          color: Color(0xFF080E59),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text(
                      '120mb', // Displaying user VPN if exists
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SizedBox(width: 100.w), // Scale width
                    SizedBox(height: 40.h), // Scale height
                  ],
                ),
                Divider(
                  color: const Color(0x80DAD9DB),
                  thickness: 1.w, // Scale thickness
                ),
                Row(
                  children: [
                    const Text(
                      'Device',
                      style: TextStyle(
                          color: Color(0xFF080E59),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    const Text(
                      '1/4', // Display device usage
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SizedBox(width: 60.w), // Scale width
                    const Text(
                      'View',
                      style: TextStyle(
                          color: Color(0xFF080E59),
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 45.w), // Scale width
                    SizedBox(height: 40.h), // Scale height
                  ],
                ),
                Divider(
                  color: const Color(0x80DAD9DB),
                  thickness: 1.w, // Scale thickness
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/images/crown.svg',
                      height: 15.h, // Scale height
                      width: 16.67.w, // Scale width
                    ),
                    SizedBox(width: 25.w), // Scale width
                    const Text(
                      'Base Plan', // Display user plan
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 74.14.w, // Scale width
                      height: 25.h, // Scale height
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xFF1D1D7D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.r), // Scale radius
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Normal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h), // Scale height
                  ],
                ),
                Divider(
                  color: const Color(0x80DAD9DB),
                  thickness: 1.w, // Scale thickness
                ),
                SizedBox(height: 50.h), // Scale height
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 121.w, // Scale width
                        height: 25.h, // Scale height
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFEC8304),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.r), // Scale radius
                            ),
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Upgrade to Premium',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 200.h), // Scale height
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/recycle.svg',
                            height: 15.h, // Scale height
                            width: 16.67.w, // Scale width
                          ),
                          SizedBox(width: 16.w), // Scale width
                          const Text(
                            'Restore',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

