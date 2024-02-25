import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:vpn_app/models/vpn_info.dart';

class AppPreferences {
  static late Box boxOfData;

  static Future<void> initHive() async {
    await Hive.initFlutter();
    boxOfData = await Hive.openBox('data');
  }

  static bool get isModeDark => boxOfData.get('isModeDark') ?? false;
  static set isModeDark(bool value) => boxOfData.put('isModeDark', value);

  static VpnInfo get vpnInfoObj =>
      VpnInfo.fromJson(jsonDecode(boxOfData.get('vpn') ?? '{}'));
  static set vpnInfoObj(VpnInfo vpnInfo) =>
      boxOfData.put('vpn', jsonEncode(vpnInfo));

  static List<VpnInfo> get vpnList {
    List<VpnInfo> tempVpnList = [];
    final dataVpn = jsonDecode(boxOfData.get('vpnList') ?? '[]');

    for (var data in dataVpn) {
      tempVpnList.add(VpnInfo.fromJson(data));
    }

    return tempVpnList;
  }

  static set vpnList(vpnList) {
boxOfData.put('vpnList', jsonEncode(vpnList));
  }
      

}
