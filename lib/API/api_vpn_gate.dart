import 'dart:convert';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/models/ip_infos.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:http/http.dart' as http;
import 'package:vpn_app/repositories/appPreferences.dart';

class APIVPNGATE {
  static Future<List<VpnInfo>> getVpnAvailableServers() async {
    final List<VpnInfo> vpnServers = [];

    try {
      final response =
          await http.get(Uri.parse('http://ww.vpngate.net/api/iphone/'));
      final commaSeparatedValueString =
          response.body.split('#')[1].replaceAll('*', '');
      List<List<dynamic>> listData =
          const CsvToListConverter().convert(commaSeparatedValueString);
      final header = listData[0];
      for (int counter = 1; counter < listData.length - 1; counter++) {
        Map<String, dynamic> jsonData = {};
        for (int innerCounter = 0;
            innerCounter < header.length;
            innerCounter++) {
          jsonData.addAll({
            header[innerCounter].toString(): listData[counter][innerCounter]
          });
        }
        vpnServers.add(VpnInfo.fromJson(jsonData));
      }
    } catch (error) {
      Get.snackbar('Error occured', error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(0.8));
    }
    vpnServers.shuffle();
    if (vpnServers.isNotEmpty) AppPreferences.vpnList = vpnServers;
    return vpnServers;
  }

  static Future<void> getIPDetails({required Rx<IPInfo> ipInfo}) async {
    try {
      final response = await http.get(Uri.parse('http://ip-api.com/json/'));
      final data = jsonDecode(response.body);
      ipInfo.value = IPInfo.fromJson(data);
    } catch (error) {
      Get.snackbar('Error occured', error.toString(),
          colorText: Colors.white,
          backgroundColor: Colors.redAccent.withOpacity(0.8));
    }
  }
}
