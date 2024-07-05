import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'constants/constants.dart';

import 'screens/calculator_screen.dart';
import 'controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CalculatorController()); //initialize the controller here
    return GetMaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: const CalculatorScreen());
  }
}
