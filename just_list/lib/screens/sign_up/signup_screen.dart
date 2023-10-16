import 'package:flutter/material.dart';
import 'package:just_list/common/sizes.dart';
import 'package:just_list/common/texts.dart';
import 'package:just_list/screens/dashboard/dashboard.dart';
import 'package:just_list/widgets/buttons/custom_buttons.dart';

import '../../common/images.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: EdgeInsets.all(tDefaultMargin),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage(tLogo),
            ),
            Form(
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(label: Text(tEmailInput)),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(label: Text(tPasswordInput)),
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(label: Text(tPasswordConfInput)),
                ),
                SizedBox(
                  height: tDefaultMargin,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    buttonText: tSignUp.toString(),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashBoardScreen()));
                    },
                  ),
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
