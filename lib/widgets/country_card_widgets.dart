import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/country_controller.dart';
import '../controllers/openvpn_controller.dart';

class CountrySpeedCard extends StatelessWidget {
  final String countryName;
  final String flagAsset;
  final String speed; // Dynamic speed value (ping)
  final Color networkIconColor;

  const CountrySpeedCard({
    super.key,
    required this.countryName,
    required this.flagAsset,
    required this.speed,
    this.networkIconColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final OpenVPNController vpnController =
    Get.find<OpenVPNController>();
    final CountryController controller = Get.put(CountryController());

    // Convert speed (ping) from string to double to use in conditions
    double pingValue = double.tryParse(speed.replaceAll('ms', '')) ?? 0.0;

    // Determine the icon and color based on ping value
    IconData networkIcon;
    Color iconColor;

    if (pingValue <= 50) {
      networkIcon = Icons.network_cell; // Good network (strong signal)
      iconColor = Colors.green; // Green for strong signal
    } else if (pingValue <= 150) {
      networkIcon = Icons.network_cell; // Average network
      iconColor = Colors.orange; // Orange for moderate signal
    } else {
      networkIcon = Icons.network_cell_rounded; // Poor network (weak signal)
      iconColor = Colors.red; // Red for weak signal
    }

    return Obx(() {
      bool isConnected = controller.selectedCountry.value.isEmpty
          ? countryName == 'India'
          : controller.selectedCountry.value == countryName;
      return Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 1),
        color: const Color(0xFFF6F6F6),
        child: SizedBox(
          height: 80,
          child: InkWell(
            onTap: () {
              controller.setCountry(countryName);
              print("Country name $countryName");
            },
            child: Center(
              child: ListTile(
                leading: Container(
                  width: 40,
                  height: 25,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(flagAsset),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Text(countryName),
                    if (isConnected) ...[
                      const SizedBox(width: 8),
                      Text(
                        vpnController.isConnected.value
                            ? "Connected"
                            : "Selected",
                        style: const TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(speed, style: const TextStyle(color: Colors.blue)),
                    const SizedBox(width: 8),
                    Transform.translate(
                      offset: const Offset(0, -3), // Move the icon 2 pixels up
                      child: Icon(networkIcon, color: iconColor), // Dynamic icon and color
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(vertical: 8.0),
                    //   child: VerticalDivider(
                    //     width: 10,
                    //     thickness: 1,
                    //     color: Color(0xFF787473),
                    //   ),
                    // ),
                    // const Icon(Icons.arrow_drop_down, color: Colors.black),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
