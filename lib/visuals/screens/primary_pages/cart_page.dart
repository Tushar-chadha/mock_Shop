import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/widgets/productCard.dart';

class CartScreen extends StatelessWidget {
  final sizeList;

  const CartScreen({super.key, this.sizeList});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
              sizeList.length, (index) => Text("Size:${sizeList[index]}")),
        ),
      ),
    );
  }
}
