import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../common/colors.dart';

class CircleButtonForward extends StatelessWidget {
  const CircleButtonForward({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      backgroundColor: tDarkit,
      radius: 15,
      child: CircleAvatar(
        radius: 14,
        backgroundColor: tBlack,
        child: Row(
          children: [
            SizedBox(
              width: 5,
            ),
            Icon(
              CupertinoIcons.forward,
              color: tWhite,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
