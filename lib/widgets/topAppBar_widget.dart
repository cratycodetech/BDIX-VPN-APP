import 'package:flutter/material.dart';

class TopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isPremium; // Accept user type as a parameter

  const TopAppBar({super.key, required this.isPremium});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0), // Add space from the top
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Elements on opposite sides
          children: [
            // Logo and Text on the left
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.png'), // Replace with your logo asset
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                const Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'BDIX',
                        style: TextStyle(
                          color: Color(0xFF393E7A),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' VPN',
                        style: TextStyle(
                          color: Color(0xFF393E7A),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // "Go Pro" icon and text on the right
            if (isPremium)
            Row(
              children: [
                const SizedBox(width: 8),
                Container(
                  width: 96,
                  height: 96,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/go_pro.png'), // Replace with your crown icon asset
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70); // Adjust height if needed
}
