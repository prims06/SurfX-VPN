import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/controllers/home_controller.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:vpn_app/repositories/appPreferences.dart';
import 'package:vpn_app/utils/extensions.dart';
import 'package:vpn_app/vpnEngine/vpn_engine.dart';

class VpnLocationCardWidget extends StatelessWidget {
  const VpnLocationCardWidget({super.key, required this.vpnInfo});
  final VpnInfo vpnInfo;

  String formatSpeedBytes(int speedBytes, int decimals) {
    if (speedBytes <= 0) {
      return '0 B';
    }

    const suffixesTitle = ['Bps', 'Kbps', 'Mbps', 'Gbps', 'Tbps'];
    var speedTitleIndex = (log(speedBytes) / log(1024)).floor();
    return '${(speedBytes / pow(1024, speedTitleIndex)).toStringAsFixed(decimals)} ${suffixesTitle[speedTitleIndex]}';
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    final homeController = Get.find<HomeController>();
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: sizeScreen.height * 0.01),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          homeController.vpnInfo.value = vpnInfo;
          AppPreferences.vpnInfoObj = vpnInfo;
          Get.back();
          if (homeController.vpnConnectionState.value ==
              VpnEngine.vpnConnectedNow) {
            VpnEngine.stopVpnNow();
            Future.delayed(
                Duration(seconds: 2), () => homeController.connectToVpnNow());
          } else {
            homeController.connectToVpnNow();
          }
        },
        borderRadius: BorderRadius.circular(16),
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          leading: Container(
            padding: const EdgeInsets.all(0.5),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Image.asset(
              'assets/images/countryFlags/${vpnInfo.countryShortName.toLowerCase()}.png',
              height: 40,
              width: sizeScreen.width * 0.15,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(vpnInfo.countryLongName),
          subtitle: Row(
            children: [
              Icon(
                Icons.shutter_speed,
                color: Colors.redAccent,
                size: 20,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                formatSpeedBytes(vpnInfo.speed, 2),
                style: TextStyle(fontSize: 13),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vpnInfo.vpnSessionsNum.toString(),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).lightTextColor),
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                CupertinoIcons.person_2_alt,
                color: Colors.redAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
