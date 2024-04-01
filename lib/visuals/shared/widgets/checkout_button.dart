import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';

class CheckoutButton extends StatelessWidget {
  CheckoutButton({
    super.key,
    required this.sizeSelected,
    required this.addDataToHiveBox,
  });

  String sizeSelected;
  final addDataToHiveBox;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: addDataToHiveBox,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 15,
          ),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Text(
            "Add to bag",
            style: poppinStyle(Colors.white, 15, FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
