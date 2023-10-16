import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/colors.dart';

class CustomSnackBarOk {
  static showSnackbarOk({required String title, required String subtitle}) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: tSnackBarOk,
        colorText: tTextColor);
  }
}

class CustomSnackBarNotOk {
  static showSnackbarNotOk({required String title, required String subtitle}) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.TOP,
        backgroundColor: tSnackBarNotOk,
        colorText: tTextColor);
  }
}

class CustomSnackBarNotOkBottom {
  static showSnackbarNotOk({required String title, required String subtitle}) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: tSnackBarNotOk,
        colorText: tTextColor);
  }
}

class CustomSnackBarOkBottom {
  static showSnackbarOk({required String title, required String subtitle}) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: tSnackBarNotOk,
        colorText: tTextColor);
  }
}

class CustomSnackBarOkTop {
  static showSnackbarOk({required String title, required String subtitle}) {
    Get.snackbar(title, subtitle,
        snackPosition: SnackPosition.TOP,
        backgroundColor: tWhite,
        colorText: tTextColor);
  }
}

class CustomSnackBarUndo {
  static showSnackbarConfUndo(
      {required String title,
      required String subtitle,
      required void Function()? undoFunction}) {
    Get.snackbar(title, subtitle,
        mainButton: TextButton(
          onPressed: () => undoFunction?.call(),
          child: const Text("Undo"),
        ),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: tWhite,
        colorText: tTextColor);
  }
}
