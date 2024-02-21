import 'package:flutter/material.dart';
import 'package:vpn_app/main.dart';

class CustomRoundWidget extends StatelessWidget {
  final String titleText;
  final String subtitleText;
  final Widget roundWidgetIcon;

  CustomRoundWidget(
      {super.key,
      required this.titleText,
      required this.subtitleText,
      required this.roundWidgetIcon});
  @override
  Widget build(BuildContext context) {
    sizeScreen = MediaQuery.of(context).size;
    return SizedBox(
      width: sizeScreen.width * 0.46,
      child: Column(
        children: [
          roundWidgetIcon,
          const SizedBox(
            height: 7,
          ),
          Text(
            titleText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            subtitleText,
            style: TextStyle(fontSize: 12 , fontWeight: FontWeight.w200),
          ),
        ],
      ),
    );
  }
}
