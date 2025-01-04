import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../routes/routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        _handleTap(context, index); // Custom tap handler for each item
        onTap(index); // Pass the tap event to the parent
      },
      selectedItemColor: const Color(0xFF080E59),
      unselectedItemColor: const Color(0xFF9B9594),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.cloud_outlined),
          label: 'Server',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }

  void _handleTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        Get.toNamed(AppRoutes.guestHome);
        break;
      case 1:
        Get.toNamed(AppRoutes.guestServerScreen);
        break;
      case 2:
        Get.toNamed(AppRoutes.normalLoginProfileScreen);
        break;
      case 3:
        Get.toNamed(AppRoutes.premiumSettingScreen);
        break;
      default:
        print('Unknown item tapped');
    }
  }
}
