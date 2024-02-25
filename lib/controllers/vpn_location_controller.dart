import 'package:get/get.dart';
import 'package:vpn_app/API/api_vpn_gate.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:vpn_app/repositories/appPreferences.dart';

class VpnLocationController extends GetxController {
  List<VpnInfo> vpnServers = AppPreferences.vpnList;

  final RxBool isLoadingNewLocation = false.obs;

  Future<void> getVpnInfo() async {
    isLoadingNewLocation.value = true;
    vpnServers.clear();

    vpnServers = await APIVPNGATE.getVpnAvailableServers();

    isLoadingNewLocation.value = false; 
  }
}
