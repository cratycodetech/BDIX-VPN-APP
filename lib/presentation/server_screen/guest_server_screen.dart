import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controllers/openvpn_controller.dart';
import '../../controllers/ping_controller.dart';
import '../../service/device_service.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/country_card_widgets.dart';
import '../../widgets/disconnect_dialog_box.dart';
import '../sign_up_screen/sign_up_screen1.dart';

class GuestServerScreen extends StatefulWidget {
  const GuestServerScreen({super.key});

  @override
  GuestServerScreenState createState() => GuestServerScreenState();
}

class GuestServerScreenState extends State<GuestServerScreen> {
  int? _selectedValue = 0;
  late int _currentIndex = 1;
  final OpenVPNController vpnController = Get.find<OpenVPNController>();
  final DeviceService _deviceService = DeviceService();

  void _handleRadioValueChange(int? value) {
    setState(() {
      _selectedValue = value;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the selected index
    });
  }

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100.h,
          ),
          Center(
            child: Container(
              width: 226.w,
              height: 215.h,
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
              offset: Offset(0, -8.h),
              child: const Divider(
                color: Color(0xFFDBD2D1),
                thickness: 1,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const Text(
            'Sign in to connect with more servers',
            style: TextStyle(
              fontSize: 14,
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
              onPressed: () async {
                if (vpnController.isConnected.value) {
                  final shouldDisconnect = await showDialog<bool>(
                    context: context,
                    builder: (context) => const DisconnectDialog(),
                  );
                  if (shouldDisconnect == true) {
                    _deviceService.removeDeviceId();
                    Get.offAll(const SignUpScreen());
                  }
                } else {
                  _deviceService.removeDeviceId();
                  Get.offAll(const SignUpScreen());
                }
              },
              child: const Text(
                'SIGN UP',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          SizedBox(height: 60.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(width: 32.w),
              const Icon(
                Icons.language,
                color: Colors.blue,
                size: 20,
              ),
              SizedBox(width: 16.w),
              const Text('Smart Location',
                  style: TextStyle(
                    fontSize: 12,
                  )),
              const Spacer(),
              Radio<int>(
                value: 0,
                groupValue: _selectedValue,
                onChanged: _handleRadioValueChange,
              ),
              SizedBox(width: 32.w),
            ],
          ),
          const Divider(
            color: Color(0xFFDBD2D1),
            thickness: 1,
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.only(left: 32.w),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Locations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //SizedBox(height: 8.h),

          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -20), // Moves the ListView 20 pixels up
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return Obx(() {
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
                      speed: pingSpeed,
                      networkIconColor: country['color']!,
                      isGuest: true,
                    );
                  });
                },
              ),
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
