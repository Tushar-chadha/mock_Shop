import 'package:flutter/material.dart';

class BottomBarButton extends StatelessWidget {
  final IconData iconName;
  bool isIconBlack;
  final Function? onTap;
  final bool isSelected;

  BottomBarButton({
    super.key,
    required this.iconName,
    this.isIconBlack = false,
    this.onTap,
    this.isSelected = false,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: avoid_print
      onTap: () => onTap!() == null ? print("myname i chag") : onTap!(),
      child: SizedBox(
        width: 38,
        height: 38,
        child: Icon(
          iconName,
          size: isSelected ? 28 : 22,
          color: isIconBlack == true ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
