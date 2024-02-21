import 'package:flutter/material.dart';
import 'package:vpn_app/repositories/appPreferences.dart';

extension AppTheme on ThemeData {
  Color get lightTextColor =>
      AppPreferences.isModeDark ? Colors.white70 : Colors.black54;
  Color get bottomNavigationColor =>
      AppPreferences.isModeDark ? Colors.white : Colors.redAccent;
      
}
