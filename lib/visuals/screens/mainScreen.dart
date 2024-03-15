import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text(
        "Hello World",
        style: poppinStyle(Colors.black, 40, FontWeight.bold),
      )),
    );
  }
}
