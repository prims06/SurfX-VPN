import 'package:get/get.dart';
import 'package:vpn_app/models/vpn_info.dart';
import 'package:vpn_app/repositories/appPreferences.dart';

class HomeController extends GetxController {
  final Rx<VpnInfo> vpnInfo = AppPreferences.vpnInfoObj.obs;
  
}
