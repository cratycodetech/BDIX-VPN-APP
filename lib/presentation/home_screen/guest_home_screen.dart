import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 32,
                  height: 32,
                ),
                const SizedBox(
                  width: 5,
                ),
                const Text(
                  'BDX VPN',
                  style: TextStyle(fontSize: 14, color: Color(0xFF393E7A)),
                )
              ],
            ),
            Transform.translate(
              offset: const Offset(0, -10),
              child: Image.asset(
                'assets/images/normal_map.png',
                width: 400,
                height: 400,
              ),
            ),
            Transform.translate(
              offset: const Offset(-110, -232),
              child: SvgPicture.asset(
                'assets/images/location_icon.svg',
                width: 14,
                height: 18,
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -130),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Status : ',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    'Connected',
                    style: TextStyle(fontSize: 12, color: Color(0xFFD77704)),
                  )
                ],
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -100),
              child: Container(
                width: double.infinity,
                height: 120,
                padding: const EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/globe_icon.svg',
                            width: 38,
                            height: 38,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text(
                            'Smart Location',
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFF545454)),
                          ),
                          const Spacer(),
                          Center(
                            child: Container(
                              width: 13.5, // Adjust the size of the circle
                              height: 13.5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(
                                    0xFF393E7A), // Background color of the circle
                              ),
                              child: const Icon(
                                Icons.done,
                                size: 10,
                                color: Colors
                                    .white, // Color of the icon inside the circle
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 12,
                          ),
                          SvgPicture.asset(
                            'assets/images/custom_down_arrow.svg',
                            width: 14,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('28.5',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text('KB/S',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              )),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/images/custom_up_arrow.svg',
                            width: 14,
                            height: 18,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('28.5',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(
                            width: 12,
                          ),
                          const Text('KB/S',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 12,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Transform.translate(
              offset: const Offset(0, -100),
              child: Container(
                width: double.infinity,
                height: 110,
                padding: const EdgeInsets.symmetric(vertical: 0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Remaining Time',
                            style: TextStyle(
                                fontSize: 14, color: Color(0xFF545454)),
                          ),
                          Spacer(),
                          Text(
                            '00:25:21',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 40,
                            width: 207,
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFEC8304),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  '+Random Time',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFFFDF3E6),
                                  ),
                                )),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 40,
                            width: 110,
                            child: OutlinedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFFEC8304),
                                    width: 1.0,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      'Go Pro',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFFEC8304),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    SvgPicture.asset(
                                      'assets/images/crown.svg',
                                      height: 10,
                                    ),
                                  ],
                                )),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, -10),
              child: SvgPicture.asset(
                'assets/images/tap_button.svg',
                width: 44,
                height: 44,
              ),
            ),
            const Text(
              'Tap to Disconnect',
              style: TextStyle(
                  fontSize: 28,
                  color: Color(0xFF393E7A),
                  fontWeight: FontWeight.bold),
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
