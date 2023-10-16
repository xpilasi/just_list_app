import 'package:flutter/material.dart';

import '../../common/images.dart';
import '../../common/sizes.dart';
import '../../common/texts.dart';
import '../../widgets/buttons/custom_buttons.dart';
import '../dashboard/dashboard.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
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
                SizedBox(
                  height: tDefaultMargin,
                ),
                SizedBox(
                  width: double.infinity,
                  child: CustomElevatedButton(
                    buttonText: tLogin.toString(),
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
    )));
  }
}
