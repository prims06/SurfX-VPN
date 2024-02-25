import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_configuration.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:vpn_app/repositories/appPreferences.dart';
import 'package:vpn_app/vpnEngine/vpn_engine.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;
  final vpnConnectionState = VpnEngine.vpnDisconnectedNow.obs;
  void connectToVpnNow() async {
    if (vpnInfo.value.base64OpenVPNConfigurationData.isEmpty) {
      Get.snackbar('Country / Location', 'You have to select any location');
      return;
    }
    if (vpnConnectionState.value == VpnEngine.vpnDisconnectedNow) {
      final dataConfigVpn =
          Base64Decoder().convert(vpnInfo.value.base64OpenVPNConfigurationData);

      final configuration = Utf8Decoder().convert(dataConfigVpn);

      final vpnConfiguration = VpnConfiguration(
          username: 'vpn',
          password: 'vpn',
          countryName: vpnInfo.value.countryLongName,
          config: configuration);

      await VpnEngine.startVpnNow(vpnConfiguration);
    } else {
      await VpnEngine.stopVpnNow();
    }
  }

  Color get getRoundVpnButtonColor {
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return Colors.redAccent;
      case VpnEngine.vpnConnectedNow:
        return Colors.green;
      default:
        return Colors.orangeAccent;
    }
  }

  String get getRoundVpnButtonText{
    switch (vpnConnectionState.value) {
      case VpnEngine.vpnDisconnectedNow:
        return 'Tap to connect';
      case VpnEngine.vpnConnectedNow:
        return 'Connected';
      default:
        return 'Connecting...';
    }
  }


}
