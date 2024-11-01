import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'screens/home_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const EarningsApp());
}

class EarningsApp extends StatelessWidget {
  const EarningsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Earnings Tracker',
      theme: AppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}
