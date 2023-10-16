import 'dart:async';

import 'package:get/get.dart';

import '../screens/dashboard/dashboard.dart';

class SplashScreenController extends GetxController {
  final showLogo = false.obs;

  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () {
      print(showLogo);
      showLogo.value = true;
      print(showLogo);
      Timer(const Duration(seconds: 3), () {
        // Navega a la pantalla principal después de 2 segundos
        Get.offAll(DashBoardScreen());
      });
    });
  }
}
