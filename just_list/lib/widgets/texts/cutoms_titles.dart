import 'package:flutter/material.dart';

class CustomTextTitle extends StatelessWidget {
  final String title;
  const CustomTextTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}
