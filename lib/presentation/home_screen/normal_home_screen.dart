import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/routes.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/topAppBar_widget.dart';

class GuestHome extends StatelessWidget {
  const GuestHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopAppBar(),
      body: Column(
        children: [
          const SizedBox(height: 20),

          // Map Image or Placeholder
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/normal_map.png'), // Replace with your map image asset
                fit: BoxFit.contain,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Status Text
          const Text(
            'Status: Disconnected',
            style: TextStyle(
              color: Color(0xFF070D51),
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),

          const Spacer(),

          // Connect Button
          Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    // Your onPressed logic here
                    Get.toNamed(AppRoutes.normalConnectHome);
                  },
                  borderRadius: BorderRadius.circular(
                      50), // Optional, for a circular ripple effect
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: const Color(0xFF080E59),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE6E7EE),
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.bolt,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Tap to Connect',
                  style: TextStyle(
                    color: Color(0xFF080E59),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Bottom Navigation Bar
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation between tabs
        },
      ),
    );
  }
}
