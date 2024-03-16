import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/appStyles.dart';
import 'package:shop/visuals/shared/bottomNavigationBar.dart';

class mainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      bottomNavigationBar: SafeArea(child: bottomNavBar()),
      body: Center(
        child: Text(
          "Hello World",
          style: poppinStyle(Colors.black87, 40, FontWeight.bold),
        ),
      ),
    );
  }
}
