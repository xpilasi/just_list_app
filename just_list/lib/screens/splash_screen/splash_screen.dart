import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/colors.dart';

import '../../controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  final SplashScreenController splashScreenController =
      Get.put(SplashScreenController());

  SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: tBlack,
          body: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 1000),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
              child: controller.showLogo.value
                  ? ScreenJustList()
                  : ScreenJustList(),
              //: const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }
}

class ScreenJustList extends StatelessWidget {
  const ScreenJustList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/logos/logo_just_list.png', height: 70),
            const Text(
              "© XPilab 2023 - V2.10",
              style: TextStyle(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}
