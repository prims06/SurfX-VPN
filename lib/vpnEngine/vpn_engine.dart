import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:vpn_app/models/vpn_configuration.dart';
import 'package:vpn_app/models/vpn_status.dart';

class VpnEngine {
  static final String eventChannelVpnStage = "vpnStage";
  static final String eventChannelVpnStatus = "vpnStatus";
  static final String methodChannelVpnControl = "vpnControl";

  static Stream<String> snapshotVpnStage() =>
      EventChannel(eventChannelVpnStage).receiveBroadcastStream().cast();

  static Stream<VpnStatus?> snapshotVpnStatus() =>
      EventChannel(eventChannelVpnStatus)
          .receiveBroadcastStream()
          .map((eventStatus) => VpnStatus.fromJson(jsonDecode(eventStatus)))
          .cast();
  static Future<void> startVpnNow(VpnConfiguration vpnConfiguration) async {
    return MethodChannel(methodChannelVpnControl).invokeMethod('start', {
      'config': vpnConfiguration.config,
      'country': vpnConfiguration.countryName,
      'username': vpnConfiguration.username,
      'password': vpnConfiguration.password
    });
  }

  static Future<void> stopVpnNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('stop');
  }

  static Future<void> killSwitchOpenNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('kill_switch');
  }

  static Future<void> refreshStageNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('refresh');
  }

  static Future<String?> getStageNow() {
    return MethodChannel(methodChannelVpnControl).invokeMethod('stage');
  }

  static Future<bool> isConnectedNow() {
    return getStageNow()
        .then((valueStage) => valueStage!.toLowerCase() == "connected");
  }

  static const String vpnConnectedNow = 'connected';
  static const String vpnDisconnectedNow = 'disconnected';
  static const String vpnWaitConnectionNow = 'wait_connection';
  static const String vpnAuthenticatingNow = 'authentificating';
  static const String vpnReconnectionNow = 'reconnect';
  static const String vpnNoConnectionNow = 'no_connection';
  static const String vpnConnectingNow = 'connecting';
  static const String vpnPrepareNow = 'prepare';
  static const String vpnDeniedNow = 'denied'; 
}
