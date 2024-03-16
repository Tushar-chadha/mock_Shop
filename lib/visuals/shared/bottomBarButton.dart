import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final IconData iconName;

  const BottomBarButton({super.key, required this.iconName});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 30,
      // ignore: avoid_print
      onTap: () => print("you pressed me"),
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(
          iconName,
          color: Colors.white,
        ),
      ),
    );
  }
}
