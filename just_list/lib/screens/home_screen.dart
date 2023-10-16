import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_list/common/sizes.dart';
import 'package:just_list/common/texts.dart';
import 'package:just_list/screens/sign_up/signup_screen.dart';

import '../common/images.dart';
import '../widgets/buttons/custom_buttons.dart';
import 'login/login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.all(tDefaultMargin),
      child: Expanded(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image(image: AssetImage(tLogo)),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomElevatedButton(
                  buttonText: tLogin,
                  onPressed: () {
                    Get.to(() => LoginScreen());
                  }),
              const SizedBox(
                width: 10,
              ),
              CustomElevatedButton(
                buttonText: tSignUp,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                },
              ),
            ],
          )
        ]),
      ),
    )));
  }
}
