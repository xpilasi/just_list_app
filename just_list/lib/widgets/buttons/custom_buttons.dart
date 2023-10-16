import 'package:flutter/material.dart';

import '../../common/colors.dart';
import '../../common/sizes.dart';

class CustomElevatedButton extends StatelessWidget {
  final buttonText;
  final void Function()? onPressed;

  const CustomElevatedButton({
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      child: TextButton(
          style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: tButtonFontSize),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              backgroundColor: tPrimaryColor,
              foregroundColor: tWhite),
          onPressed: onPressed,
          child: Text(buttonText.toUpperCase())),
    );
  }
}

class CustomDialogButton extends StatelessWidget {
  final buttonText;
  final Color textColor;
  final void Function()? onPressed;

  const CustomDialogButton({
    super.key,
    this.buttonText,
    this.onPressed,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: tButtonHeigh,
      child: TextButton(
          style: TextButton.styleFrom(
            textStyle: const TextStyle(fontSize: tButtonFontSize),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            //backgroundColor: tSecondaryColor,
            foregroundColor: textColor,
          ),
          onPressed: onPressed,
          child: Text(buttonText.toUpperCase())),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  final void Function()? onPressed;

  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: const Icon(Icons.arrow_back_ios_new_outlined),
      //color: Colors.black,
    );
  }
}

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  final double size;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.icon,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size),
      //color: Colors.black,
    );
  }
}

class AppBarButton extends StatelessWidget {
  final String text;
  final double size;
  final void Function()? onPressed;

  const AppBarButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
              foregroundColor: tSecondaryColor,
              backgroundColor: tPrimaryColor,
              minimumSize: const Size.fromHeight(10),
              fixedSize: const Size(0, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30))),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: tWhite,
            ),
          )),
    );
  }
}

class SaveListButton extends StatelessWidget {
  final String text;
  final double size;
  final void Function()? onPressed;

  const SaveListButton({
    super.key,
    required this.text,
    this.onPressed,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.transparent),
              foregroundColor: tPrimaryColor,
              backgroundColor: tPrimaryColor,
              minimumSize: const Size.fromHeight(10),
              fixedSize: const Size(0, 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40))),
          onPressed: onPressed,
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: tWhite,
            ),
          )),
    );
  }
}
