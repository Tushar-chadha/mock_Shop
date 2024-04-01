import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/mainScreenController.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with TickerProviderStateMixin {
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
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Cart",
                  style: poppinStyle(Colors.black, 40, FontWeight.bold),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.black)),
                  onPressed: () {
                    setState(() {
                      cart.clear();
                      _cartBox.clear();
                    });
                  },
                  child: const Row(
                    children: [
                      Icon(
                        MaterialCommunityIcons.cart_off,
                        color: Colors.white,
                        size: 18,
                      ),
                      Gap(5),
                      Text(
                        'Remove All',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Consumer<MainScreenNotifier>(
              builder: (context, mainScreenNotifier, child) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, commonSize.height * 0.07, 0, 0),
              height: commonSize.height,
              child: cart.isEmpty
                  ? Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Empty Cart.",
                            textAlign: TextAlign.center,
                            style:
                                poppinStyle(Colors.black, 30, FontWeight.bold),
                          ),
                          const Gap(5),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black87),
                              shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            onPressed: () {
                              mainScreenNotifier.pageIndex = 0;
                            },
                            child: Text(
                              "Back to homepage",
                              style: poppinStyle(
                                  Colors.white, 20, FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cart.length,
                      itemBuilder: (_, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              setState(() {
                                cart.removeAt(index);
                                _cartBox.deleteAt(index);
                              });
                            },
                            background: Container(
                              decoration: const BoxDecoration(
                                color: Colors.black,
                                borderRadius:
                                    BorderRadiusDirectional.horizontal(
                                  end: Radius.circular(10),
                                ),
                              ),
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 50.0),
                              child: Icon(AntDesign.delete,
                                  color: Colors.red.shade900),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              height: commonSize.height * 0.13,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                children: [
                                  CachedNetworkImage(
                                      imageUrl: cart[index]['imgUrl']),
                                  const Gap(10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        cart[index]['name'],
                                        style: poppinStyle(
                                            Colors.black, 18, FontWeight.bold),
                                      ),
                                      Text(
                                        cart[index]['category'],
                                        style: poppinStyle(Colors.grey.shade400,
                                            16, FontWeight.w600),
                                      ),
                                      Text(
                                        "Rs.${cart[index]['price']}",
                                        style: poppinStyle(
                                            Colors.black, 16, FontWeight.w600),
                                      ),
                                      Text(
                                        "Qty: ${cart[index]['quantity'].toString()}",
                                        style: poppinStyle(
                                            Colors.black, 16, FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            );
          }),
        ],
      ),
    );
  }
}
