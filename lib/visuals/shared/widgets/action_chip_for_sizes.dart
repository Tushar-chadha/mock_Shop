import 'package:flutter/material.dart';
import 'package:shop/controller/productController.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';

class actionChipForSizes extends StatelessWidget {
  final int index;
  final ProductNotifier productNotifier;
  const actionChipForSizes({
    super.key,
    required this.sizes,
    required this.productNotifier,
    required this.index,
  });
  final sizes;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: ChoiceChip(
        showCheckmark: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
            side: const BorderSide(
                color: Colors.black, width: 1, style: BorderStyle.solid)),
        disabledColor: Colors.white,
        label: Text(
          sizes['size'],
          style: poppinStyle(sizes['isSelected'] ? Colors.white : Colors.black,
              18, FontWeight.w500),
        ),
        selectedColor: Colors.black,
        padding: const EdgeInsets.symmetric(vertical: 8),
        selected: sizes['isSelected'],
        onSelected: (newState) {
          if (productNotifier.finalShoeSizeGetter == sizes['size']) {
            productNotifier.setterFinalShoeSize = sizes['size'];
            // if size clicked on screen is in finalShoeSizeGetter List then it will remove from the list
          }
          productNotifier.isToggle(index);
        },
      ),
    );
  }
}
