import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/components/custom_round_widget.dart';
import 'package:vpn_app/controllers/home_controller.dart';
import 'package:vpn_app/main.dart';
import 'package:vpn_app/models/vpn_status.dart';
import 'package:vpn_app/repositories/appPreferences.dart';
import 'package:vpn_app/vpnEngine/vpn_engine.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final homeController = Get.find<HomeController>();
  locationSelectionBottomNav(BuildContext context) {
    return SafeArea(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: () {},
          child: Container(
            color: Colors.redAccent,
            padding: EdgeInsets.symmetric(horizontal: sizeScreen.width * 0.041),
            height: 62,
            child: const Row(
              children: [
                Icon(
                  CupertinoIcons.flag_circle,
                  color: Colors.white,
                  size: 36,
                ),
                SizedBox(
                  width: 12,
                ),
                Text(
                  'Select Location',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Spacer(),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.redAccent,
                    size: 26,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget vpnRoundedButton() {
    return Column(
      children: [
        Semantics(
          button: true,
          child: InkWell(
            onTap: () {},
            child: Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      homeController.getRoundVpnButtonColor.withOpacity(0.1)),
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        homeController.getRoundVpnButtonColor.withOpacity(0.3)),
                child: Container(
                  width: sizeScreen.height * .14,
                  height: sizeScreen.height * .14,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.getRoundVpnButtonColor),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 30,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          homeController.getRoundVpnButtonText,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text('SurfX VPN'),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.perm_device_info_outlined),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Get.changeThemeMode(AppPreferences.isModeDark
                    ? ThemeMode.light
                    : ThemeMode.dark);

                AppPreferences.isModeDark = !AppPreferences.isModeDark;
              },
              icon: Icon(Icons.brightness_2_outlined))
        ],
      ),
      bottomNavigationBar: locationSelectionBottomNav(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundWidget(
                    titleText:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? 'Location'
                            : homeController.vpnInfo.value.countryLongName,
                    subtitleText: 'FREE',
                    roundWidgetIcon: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black54,
                      child:
                          homeController.vpnInfo.value.countryLongName.isEmpty
                              ? Icon(
                                  Icons.flag_circle,
                                  color: Colors.white,
                                  size: 30,
                                )
                              : null,
                      backgroundImage: (!homeController
                              .vpnInfo.value.countryLongName.isEmpty)
                          ? AssetImage(
                              'assets/images/countryFlags/${homeController.vpnInfo.value.countryShortName.toLowerCase()}.png')
                          : null,
                    )),
                CustomRoundWidget(
                    titleText:
                        homeController.vpnInfo.value.countryLongName.isEmpty
                            ? '60 ms'
                            : '${homeController.vpnInfo.value.ping} ms',
                    subtitleText: 'PING',
                    roundWidgetIcon: const CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black54,
                      child: Icon(
                        Icons.flag_circle,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
              ],
            ),
          ),
          vpnRoundedButton(),
          StreamBuilder<VpnStatus?>(
              initialData: VpnStatus(),
              stream: VpnEngine.snapshotVpnStatus(),
              builder: ((context, snapshot) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomRoundWidget(
                        titleText: "${snapshot.data?.byteIn}??'0 kbps'",
                        subtitleText: 'DOWNLOAD',
                        roundWidgetIcon: const CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.greenAccent,
                          child: Icon(
                            Icons.arrow_circle_down,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                    CustomRoundWidget(
                        titleText: "${snapshot.data?.byteOut}??'0 kbps'",
                        subtitleText: 'UPLOAD',
                        roundWidgetIcon: const CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.purpleAccent,
                          child: Icon(
                            Icons.arrow_circle_up,
                            color: Colors.white,
                            size: 30,
                          ),
                        )),
                  ],
                );
              }))
        ],
      ),
    );
  }
}
