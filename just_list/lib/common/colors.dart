import 'dart:math';

import 'package:flutter/material.dart';

//final Color tPrimaryColor = Color.fromARGB(255, 53, 134, 106);
const Color tBackgroundButtonColor = Color.fromARGB(255, 71, 71, 71);
const Color tLightRed = Color.fromARGB(255, 245, 197, 203);
const Color tListTile = Color.fromARGB(255, 236, 255, 248);
const Color tPink = Color.fromARGB(255, 250, 178, 229);
const Color tPrimaryColor = Color.fromARGB(255, 41, 225, 210);
const Color tSecondaryColor = Color.fromARGB(255, 143, 224, 196);
const Color tSnackBarNotOk = Color.fromARGB(255, 245, 197, 203);
const Color tSnackBarOk = Color.fromARGB(255, 213, 240, 197);
const Color tDarkit = Color.fromARGB(255, 142, 142, 142);
const Color tDark = Color.fromARGB(255, 65, 65, 65);
const Color tDarker = Color.fromARGB(255, 34, 34, 34);
const Color tTestColor = Color.fromARGB(255, 128, 133, 239);
const Color tTextColor = Color.fromARGB(255, 92, 92, 92);
const Color tWhite = Color.fromARGB(255, 255, 255, 255);
const Color tBlack = Color.fromARGB(255, 0, 0, 0);
const Color tRedDelete = Color.fromARGB(255, 231, 150, 150);

//Color schema:

const Color tBlueS = Color.fromARGB(255, 40, 108, 255);
const int tBlueInt = 0xFF286CFF; //OK

const Color tDarkPurpleS = Color.fromARGB(255, 134, 0, 201);
const int tDarkPurpleInt = 0xFF8600C9; //OK

const Color tGreenS = Color.fromARGB(255, 34, 163, 29);
const int tGreenInt = 0xFF48F38C; //OK

const Color tPinkS = Color.fromARGB(255, 255, 51, 187);
const int tPinkInt = 0xFFFF33BB; //OK

const Color tPurpleS = Color.fromARGB(255, 200, 123, 255);
const int tPurpleInt = 0xFFC87BFF; //OK

const Color tTurkS = Color.fromARGB(255, 0, 255, 204);
const int tTurkInt = 0xFF00FFCC; //OK

const Color tYellowS = Color.fromARGB(255, 255, 197, 50);
const int tYellowInt = 0xFFFFC532; //OK

//List of Colors in strings:
const colorList = [
  tBlueInt,
  tDarkPurpleInt,
  tGreenInt,
  tPinkInt,
  //tPurpleInt,
  tTurkInt,
  tYellowInt,
];

//Generate random color from the list and saving it as a string so it
//can be read by Hive:
generateRandomColorInt() {
  final randomColor = Random();
  var tRandomColorList = colorList[randomColor.nextInt(colorList.length)];
  //print(tRandomColorList);
  return tRandomColorList;
}
