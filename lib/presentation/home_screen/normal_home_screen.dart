import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/routes.dart';
import '../../widgets/bottomNavigationBar_widget.dart';
import '../../widgets/topAppBar_widget.dart';
import '../../controllers/openvpn_controller.dart';
import '../home_screen/normal_home_connect_screen.dart';

class GuestHome extends StatefulWidget {
  const GuestHome({Key? key}) : super(key: key);

  @override
  State<GuestHome> createState() => _GuestHomeState();
}

class _GuestHomeState extends State<GuestHome> {
  final OpenVPNController vpnController =
      Get.find<OpenVPNController>(); // Access the OpenVPNController

  @override
  void initState() {
    super.initState();
    _loadConfig();
    _observeConnection();
  }

  Future<void> _loadConfig() async {
    final loadedConfig =
        await DefaultAssetBundle.of(context).loadString('assets/client1.ovpn');
    vpnController.vpnConfig.value = loadedConfig; // Update the controller's config
  }

  void _observeConnection() {
    // Observe the connection status and navigate when connected
    vpnController.isConnected.listen((connected) {
      if (connected) {
        // Navigate to GuestHomeScreen when connected
        Future.microtask(() => Get.off(() => GuestHomeScreen(engine: vpnController.engine)));
      }
    });
  }

  Future<void> _startVPN() async {
    try {
    vpnController.connect();// Use controller's connect method
    print("VPN Connection Started...");
  } catch (e) {
    print("Error starting VPN: $e");
  } 
  }

  void _stopVPN() {
    vpnController.disconnect(); // Use controller's disconnect method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const TopAppBar(),
      body: Obx(() {
        return Column(
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
            Text(
              'Status: ${vpnController.vpnStage.value}',
              style: const TextStyle(
                color: Color(0xFF070D51),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),

            const Spacer(),

            // Connect Button with Loading Indicator
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
