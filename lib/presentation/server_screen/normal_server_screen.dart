import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/ping_controller.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/country_card_widgets.dart';

class NormalServerScreen extends StatefulWidget {
  const NormalServerScreen({super.key});

  @override
  State<NormalServerScreen> createState() => _NormalServerScreenState();
}

class _NormalServerScreenState extends State<NormalServerScreen> {
  int? _selectedValue = 0;
  late int _currentIndex = 1;

  final PingController pingController = Get.put(PingController());



  final List<Map<String, dynamic>> countries = [
    {
      'countryName': 'Singapore',
      'flagAsset': 'assets/images/singapore_flag.png',
      'speed': 'Loading...', // Default placeholder
      'color': Colors.black,
    },
    {
      'countryName': 'India',
      'flagAsset': 'assets/images/india_flag.png',
      'speed': 'Loading...',
      'color': Colors.black,
    },
    {
      'countryName': 'USA',
      'flagAsset': 'assets/images/usa_flag.png',
      'speed': 'Loading...',
      'color': Colors.black,
    },
    {
      'countryName': 'Finland',
      'flagAsset': 'assets/images/finland_flag.png',
      'speed': 'Loading...',
      'color': Colors.black,
    },
  ];

  @override
  void initState() {
    super.initState();
    pingController.startPing();
  }





  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }





  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.blue,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
        ),
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 140,
                    height: 44,
                    child: Text(
                      'All Locations',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(26),
                      color: const Color(0xFFF9F9F9),
                    ),
                    child: const TextField(
                      textAlign: TextAlign.start,
                      decoration: InputDecoration(
                        hintText: 'Search Location',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 50),
                const Icon(
                  Icons.language,
                  color: Colors.blue,
                  size: 20,
                ),
                const SizedBox(width: 16),
                const Text('Smart Location',
                    style: TextStyle(
                      fontSize: 12,
                    )),
                const Spacer(),
                Radio<int>(
                  value: 1,
                  groupValue: _selectedValue,
                  onChanged: _handleRadioValueChange,
                ),
                const SizedBox(width: 32),
              ],
            ),
            const Divider(
              color: Color(0xFFDBD2D1),
              thickness: 1,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Free Locations',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: countries.length,
              itemBuilder: (context, index) {
                final country = countries[index];
                return Obx(() {
                  // Bind the ping value from the PingController
                  String pingSpeed = '';

                  switch (country['countryName']) {
                    case 'USA':
                      pingSpeed = pingController.usaPing.value;
                      break;
                    case 'India':
                      pingSpeed = pingController.indiaPing.value;
                      break;
                    case 'Finland':
                      pingSpeed = pingController.finlandPing.value;
                      break;
                    case 'Singapore':
                      pingSpeed = pingController.singaporePing.value;
                      break;
                  }

                  return CountrySpeedCard(
                    countryName: country['countryName']!,
                    flagAsset: country['flagAsset']!,
                    speed: pingSpeed, // Update the speed with live ping data
                    networkIconColor: country['color']!,
                  );
                });
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

