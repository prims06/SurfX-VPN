import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/components/vpn_location_card_widget.dart';
import 'package:vpn_app/controllers/vpn_location_controller.dart';

class AvailableVPNServersScreen extends StatelessWidget {
  AvailableVPNServersScreen({super.key});

  final vpnLocationController = VpnLocationController();
  @override
  Widget build(BuildContext context) {
    if (vpnLocationController.vpnServers.isEmpty) {
      vpnLocationController.getVpnInfo();
    }
    loadingUIWidget() {
      return const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.redAccent),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Gathering Free VPN Locations...",
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      );
    }

    noVpnServerFoundUIWidget() {
      return const Center(
        child: Text(
          "No Vpns Found, Try again !",
          style: TextStyle(
              fontSize: 16, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      );
    }

    vpnServersDataUIWidget() {
      return ListView.builder(
        itemCount: vpnLocationController.vpnServers.length,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(3),
        itemBuilder: (context, index) {
          return VpnLocationCardWidget(
              vpnInfo: vpnLocationController.vpnServers[index]);
        },
      );
    }

    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.redAccent,
            title: Text(
                'VPN Locations (${vpnLocationController.vpnServers.length})'),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: 10, right: 10),
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed: () {
                vpnLocationController.getVpnInfo();
              },
              child: Icon(CupertinoIcons.refresh_circled, size: 40,),
            ),
          ),
          body: vpnLocationController.isLoadingNewLocation.value
              ? loadingUIWidget()
              : vpnLocationController.vpnServers.isEmpty
                  ? noVpnServerFoundUIWidget()
                  : vpnServersDataUIWidget(),
        ));
  }
}
