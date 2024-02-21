import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_app/repositories/appPreferences.dart';
import 'package:vpn_app/screens/home_screen.dart';

late Size sizeScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreferences.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'SurfX VPN',
        theme: ThemeData(
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 3),
          useMaterial3: true,
        ),
        themeMode: AppPreferences.isModeDark ? ThemeMode.dark : ThemeMode.light,
        darkTheme: ThemeData(
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 3),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home:  HomeScreen());
  }
}
