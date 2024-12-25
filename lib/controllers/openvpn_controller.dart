import 'package:get/get.dart';
import 'package:openvpn_flutter/openvpn_flutter.dart';

class OpenVPNController extends GetxController {
  late final OpenVPN engine;

  final Rx<VpnStatus?> vpnStatus = Rx<VpnStatus?>(null); // Observable status
  final RxString vpnStage = "Disconnected".obs; // Observable stage
  final RxBool isConnected = false.obs; // Observable connection status

  final RxString vpnConfig = "".obs; // VPN configuration
  static const String defaultVpnUsername = "root"; // Default VPN username
  static const String defaultVpnPassword = "vpnserver123456"; // Default VPN password

  OpenVPNController() {
    engine = OpenVPN(
      onVpnStatusChanged: (VpnStatus? status) {
        vpnStatus.value = status;
        isConnected.value = status?.connectedOn != null;
      },
      onVpnStageChanged: (VPNStage stage, String raw) {
        vpnStage.value = stage.name; // Extract the `name` property
      },
    );
  }

  Future<void> init() async {
    await engine.initialize(
      groupIdentifier: "group.com.laskarmedia.vpn",
      providerBundleIdentifier: "id.laskarmedia.openvpnFlutterExample.VPNExtension",
      localizedDescription: "VPN by Nizwar",
      lastStage: (VPNStage stage) => vpnStage.value = stage.name,
      lastStatus: (VpnStatus? status) {
        vpnStatus.value = status;
        isConnected.value = status?.connectedOn != null;
      },
    );
  }

  Future<void> connect() async {
    if (vpnConfig.value.isEmpty) {
      vpnStage.value = "Config not loaded";
      return;
    }
    try {
      await engine.connect(
        vpnConfig.value,
        "MyVPNProfile",
        username: defaultVpnUsername,
        password: defaultVpnPassword,
        certIsRequired: true,
      );
    } catch (error) {
      vpnStage.value = "Disconnected";
    }
  }

  void disconnect() {
    engine.disconnect();
    isConnected.value = false;
    vpnStage.value = "Disconnected";
  }
}
