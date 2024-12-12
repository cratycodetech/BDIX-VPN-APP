import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../widgets/bottomNavigationBar_widget.dart';

class NormalLoginProfileScreen extends StatefulWidget {
  const NormalLoginProfileScreen({super.key});

  @override
  State<NormalLoginProfileScreen> createState() =>
      _NormalLoginProfileScreenState();
}

class _NormalLoginProfileScreenState extends State<NormalLoginProfileScreen> {

  late int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
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
                const Text(
                  '284529462',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                SvgPicture.asset(
                  'assets/images/pencil.svg',
                  height: 15,
                  width: 16.67,
                ),
                const Checkbox(
                  value: false,
                  onChanged: null,
                ),
              ],
            ),
            const Divider(
              color: Color(0x80DAD9DB),
              thickness: 1,
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
                const Text(
                  'email',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const SizedBox(width: 60,),
                SvgPicture.asset(
                  'assets/images/pencil.svg',
                  height: 15,
                  width: 16.67,
                ),
                const Checkbox(
                  value: false,
                  onChanged: null,
                ),
              ],
            ),
            const Divider(
              color: Color(0x80DAD9DB),
              thickness: 1,
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
                const Text(
                  '*********',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                const SizedBox(width: 70,),
                SvgPicture.asset(
                  'assets/images/pencil.svg',
                  height: 15,
                  width: 16.67,
                ),
                const Checkbox(
                  value: false,
                  onChanged: null,
                ),
              ],
            ),
            const Divider(
              color: Color(0x80DAD9DB),
              thickness: 1,
            ),
            const Row(
              children: [
                Text(
                  'VPN',
                  style: TextStyle(
                      color: Color(0xFF080E59),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '120mb',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(width: 100,),
                SizedBox(height: 40,),
              ],
            ),
            const Divider(
              color: Color(0x80DAD9DB),
              thickness: 1,
            ),
            const Row(
              children: [
                Text(
                  'Device',
                  style: TextStyle(
                      color: Color(0xFF080E59),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '1/4',
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                SizedBox(width: 60,),
                Text(
                  'View',
                  style: TextStyle(
                      color: Color(0xFF080E59),
                      fontSize: 10,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 45,),
                SizedBox(height: 40,),
              ],
            ),
            const Divider(
              color: Color(0x80DAD9DB),
              thickness: 1,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/crown.svg',
                  height: 15,
                  width: 16.67,
                ),
                const SizedBox(width: 25,),
                const Text(
                  'Base Plan',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                SizedBox(
                  width: 74.14, // Button width
                  height: 25, // Button height
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFF1D1D7D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
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
                const SizedBox(height: 40,),
              ],
            ),
            const Divider(
              color: Color(0x80DAD9DB),
              thickness: 1,
            ),

            const SizedBox(height: 50,),

            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 121, // Button width
                    height: 25, // Button height
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFEC8304),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
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
                  const SizedBox(height: 200),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/recycle.svg',
                        height: 15,
                        width: 16.67,
                      ),
                      const SizedBox(width: 16),
                      const Text(
                        'Restore',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            )

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
