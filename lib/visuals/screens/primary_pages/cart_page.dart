import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';
import 'package:shop/visuals/shared/widgets/productCard.dart';

class CartScreen extends StatelessWidget {
  final _cartBox = Hive.box("cart_box");

  @override
  Widget build(BuildContext context) {
    var commonSize = MediaQuery.of(context).size;
    List<dynamic> cart = [];
    final cartData = _cartBox.keys.map((key) {
      final item = _cartBox.get(key);
      return {
        "Key": key,
        "id": item["id"],
        "name": item["name"],
        "category": item["category"],
        "price": item["price"],
        "imgUrl": item["imgUrl"],
        "size": item["size"],
        "quantity": item["quantity"]
      };
    }).toList();
    cart = cartData.reversed.toList();

    return Padding(
      padding: EdgeInsets.fromLTRB(0, commonSize.height * 0.08, 0, 0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cart",
                  style: poppinStyle(Colors.black, 40, FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      _cartBox.clear();
                      print(cart);
                    },
                    child: Icon(MaterialCommunityIcons.cart_off)),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Row(
                  children: [
                    CachedNetworkImage(imageUrl: cart[0]['imgUrl']),
                    Gap(10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          cart[0]['name'],
                          style: poppinStyle(Colors.black, 18, FontWeight.bold),
                        ),
                        Text(
                          cart[0]['category'],
                          style: poppinStyle(
                              Colors.grey.shade400, 16, FontWeight.w600),
                        ),
                        Text(
                          cart[0]['price'].toString(),
                          style: poppinStyle(Colors.black, 16, FontWeight.w600),
                        ),
                        Text(
                          "Qty: ${cart[0]['quantity'].toString()}",
                          style: poppinStyle(Colors.black, 16, FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
