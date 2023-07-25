import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sql_with_api_testing/src/presentation/view/home_screen/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(seconds: 1), () {
        Get.off(const HomeScreen());
      });
    });
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.polymer,
          size: 200,
        ),
      ),
    );
  }
}
