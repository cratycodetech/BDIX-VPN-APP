import 'dart:async';
import 'dart:io';

import 'package:bdix_vpn/service/device_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../advertisment/reworded_ad.dart';
import '../../controllers/country_controller.dart';
import '../../models/user_preferences.dart';
import '../../providers/timer_provider.dart';
import '../../routes/routes.dart';
import '../../service/database/database_helper.dart';
import '../../service/notification_service.dart';
import '../../service/user_service.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/topAppBar_widget.dart';
import '../../controllers/openvpn_controller.dart';
import 'guest_home_screen.dart';

class GuestHome extends ConsumerStatefulWidget {
  const GuestHome({super.key});

  @override
  ConsumerState<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends ConsumerState<GuestHome> {
  final OpenVPNController vpnController =
  Get.find<OpenVPNController>();
  final UserService _userService = UserService();
  final DeviceService _deviceService = DeviceService();
  final RewardedAdManager _rewardedAdManager = RewardedAdManager();
  bool isPremium = false;
  bool isCurrentScreen = true;
  bool isGuest = false;
  DateTime? sessionStartTime;
  bool showMoreAd = false;

  final List<String> countryNames = ['USA', 'India', 'UK'];
  final Map<String, String> countryConfigFiles = {
    'USA': 'assets/VPNFile/usa_server.ovpn',
    'India': 'assets/VPNFile/indian_server.ovpn',
    'Finland': 'assets/VPNFile/finland_server.ovpn',
    'Singapore': 'assets/VPNFile/client1.ovpn',
  };



  @override
  void initState() {
    super.initState();
    _observeConnection();
    _loadUserType();
    _conditionalStartVPN();
    _initializeGuestStatus();
    _loadRewardedAd();
    _loadAdPreferences();

  }

  @override
  void dispose() {
    super.dispose();
    isCurrentScreen = false;
  }


  Future<void> _loadRewardedAd() async {
    _rewardedAdManager.loadRewardedAd(
      onAdLoaded: () => print('Rewarded ad loaded.'),
      onAdFailed: () => print('Failed to load rewarded ad.'),
    );
  }

  Future<void> _loadAdPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    showMoreAd = prefs.getBool('showMoreAd') ?? false;
    setState(() {});
  }

  void _showRewardedAd() {
    _rewardedAdManager.showRewardedAd(
      context: context,
      onRewardEarned: () {
        print('User earned reward for watching the ad.');
        // Add logic for what happens when the reward is earned
      },
    );
  }

  Future<void> _initializeGuestStatus() async {

    isGuest = await _deviceService.checkGuestStatus();
    setState(() {});
  }

  Future<void> _loadUserType() async {
    bool userType = await _userService.getUserType();
    setState(() {
      isPremium = userType;
    });
  }

  void _observeConnection() {

    vpnController.isConnected.listen((connected) async {
      print("connected status $connected");
      if (connected) {
        //ref.read(timerProvider.notifier).resetTimer();
        await Future.delayed(const Duration(milliseconds: 300));
        //ref.read(timerProvider.notifier).resetTimer();
        ref.read(timerProvider.notifier).startTimer();
        sessionStartTime= DateTime.now();
        _saveSessionStartTime(sessionStartTime!);
        if (isGuest && showMoreAd) {
          _showRewardedAd();
        }
        Get.offAll(() => const GuestHomeScreen());
      }
    });
  }

  Future<void> _saveSessionStartTime(DateTime sessionTime) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('session_start_time', sessionTime.toIso8601String());
  }


  Future<void> _conditionalStartVPN() async {
    try{
      final DatabaseHelper dbHelper = DatabaseHelper();
      final String? userId = await _userService.getUserId();
      final UserPreferences? preferences = await dbHelper.getUserPreferences(userId!);

      if (preferences?.connectOnStart == true){
        vpnController.connect();
      }
    } catch (e) {
      print("Error starting VPN: $e");
    }
  }

  final CountryController countryController = Get.put(CountryController());

  Future<void> _startVPN() async {
    try {
      await countryController.loadConfigForCountry();
      vpnController.vpnConfig.value = countryController.vpnConfig.value;
      vpnController.connect();
      print("VPN Connection Started...");
    } catch (e) {
      print("Error starting VPN: $e");
    }
  }


  void _stopVPN() {
    vpnController.disconnect();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: Colors.white,
      appBar: TopAppBar(isPremium: isPremium,isGuest: isGuest),
      body: Obx(() {
        return Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: 300,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/normal_map.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Status Text
            Text(
              'Status: ${vpnController.vpnStage.value}',
              style: const TextStyle(
                color: Color(0xFF070D51),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            Center(
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      if (vpnController.isConnected.value) {
                        _stopVPN();
                      } else {
                        _startVPN();
                      }
                    },
                    borderRadius:
                    BorderRadius.circular(50), // Circular ripple effect
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: vpnController.isConnected.value
                                ? Colors.green
                                : const Color(0xFF080E59),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFE6E7EE),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            vpnController.isConnected.value
                                ? Icons.check
                                : Icons.bolt,
                            color: Colors.white,
                            size: 40,
                          ),
                        ),
                        if (vpnController.vpnStage.value == "Connecting...")
                          const SizedBox(
                            width: 50,
                            height: 50,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    vpnController.isConnected.value
                        ? 'Connected'
                        : (vpnController.vpnStage.value == "Connecting..."
                        ? 'Connecting...'
                        : 'Tap to Connect'),
                    style: const TextStyle(
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
        );
      }),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 0,
        onTap: (index) {
          // Handle navigation between tabs
        },
      ),
    );
  }
}