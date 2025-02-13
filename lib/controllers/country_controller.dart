import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/openvpn_controller.dart';
import '../utils/scaffold_messenger_utils.dart'; // Import OpenVPNController

class CountryController extends GetxController {
  var selectedCountry = ''.obs;
  var vpnConfig = ''.obs;
  final OpenVPNController vpnController = Get.find<OpenVPNController>(); // Get VPN Controller

  final Map<String, String> countryConfigFiles = {
    'USA': 'assets/VPNFile/usa_server.ovpn',
    'India': 'assets/VPNFile/indian_server.ovpn',
    'Finland': 'assets/VPNFile/finland_server.ovpn',
    'Singapore': 'assets/VPNFile/client1.ovpn',
  };

  @override
  void onInit() {
    super.onInit();
    ever(selectedCountry, (_) => _switchServer());
  }

  void setCountry(String countryName) {
    print("Selected Country: $countryName");
    selectedCountry.value = countryName;
  }

  Future<void> _switchServer() async {
    if (selectedCountry.value.isEmpty) return;

    // Stop existing VPN connection before switching
    if (vpnController.isConnected.value) {
      print("Disconnecting current VPN before switching...");
      await vpnController.disconnect();
      ever(vpnController.isConnected, (connected) async {
        if (!connected) {
          return;
        }
      });

    }

    print("Switching to new VPN server: ${selectedCountry.value}");
    //showScaffoldMessage(context, "Switching to new VPN server: ${selectedCountry.value}");
    await loadConfigForCountry();
    await vpnController.connect();
  }

  Future<void> loadConfigForCountry() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String country = selectedCountry.value.isNotEmpty
          ? selectedCountry.value
          : 'India';

      String? configPath = countryConfigFiles[country];
      print("Loading VPN config for: $country");
      if (configPath != null) {
        vpnConfig.value = await rootBundle.loadString(configPath);
        await prefs.setString('country', country);
        vpnController.vpnConfig.value = vpnConfig.value; // Set VPN config
      } else {
        print("No VPN config found for selected country: $country");
      }
    } catch (e) {
      print("Error loading VPN config: $e");
    }
  }
}
