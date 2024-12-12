import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
          const SizedBox(
            height: 150,
          ),
          Center(
            child: Container(
              width: 226,
              height: 210,
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
            width: 225.71,
            child: Transform.translate(
              offset: const Offset(0, -8), // Move the divider 3 pixels up
              child: const Divider(
                color: Color(0xFFDBD2D1),
                thickness: 1,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Looks like you are not signed in yet',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
              letterSpacing: -0.02,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 90, // Button width
            height: 36, // Button height
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFF1D1D7D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Row(
            children: [
              SizedBox(width: 32),
              Text(
                'ID',
                style: TextStyle(
                    color: Color(0xFF080E59),
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 60),
              Text(
                '284529462',
                style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(), // This will push the checkbox to the far right
              Checkbox(
                value: false, // If you want the checkbox to be unchecked initially
                onChanged: null, // Add functionality if needed
              ),
              SizedBox(width: 32),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 32),
              SvgPicture.asset(
                'assets/images/crown.svg',
                height: 15,
                width: 16.67,
              ),
              const SizedBox(width: 32),
              const Text(
                'Base Plan',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              SizedBox(
                width: 70,
                height: 25,
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
                    'Guest',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 42),
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
