import 'package:flutter/material.dart';

import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/info_card_widget.dart';
import '../../widgets/rating_card_widget.dart';

class ConnectionReportScreen extends StatefulWidget {
  const ConnectionReportScreen({super.key});

  @override
  ConnectionReportScreenState createState() => ConnectionReportScreenState();
}

class ConnectionReportScreenState extends State<ConnectionReportScreen> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 0) {
        Navigator.pushNamed(context, '/home');
      } else if (index == 1) {
        Navigator.pushNamed(context, '/server');
      } else if (index == 2) {
        Navigator.pushNamed(context, '/profile');
      } else if (index == 3) {
        Navigator.pushNamed(context, '/settings');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 300.85,
              color: const Color(0xFFF6C68C),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Container(
              height: 300.85,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/report_page_map.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        'Connection Report',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const InfoCard(),
                const SizedBox(height: 30),
                const RatingCard(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
