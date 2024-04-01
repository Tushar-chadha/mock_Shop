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
                Row(
                  children: [
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          _cartBox.clear();
                          cart.clear();
                          print(cart);
                        });
                      },
                      icon: Icon(MaterialCommunityIcons.cart_off),
                    ),
                    const SizedBox(
                        width:
                            8), // Add some spacing between the IconButton and Text
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _cartBox.clear();
                          cart.clear();
                          print(cart);
                        });
                      },
                      child: Text(
                        'Remove All',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16, // Adjust font size as needed
                          // Add other text styles as needed
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Consumer<MainScreenNotifier>(
              builder: (context, mainScreenNotifier, child) {
            return Container(
              padding: EdgeInsets.fromLTRB(0, commonSize.height * 0.07, 0, 0),
              height: commonSize.height,
              child: cart.isEmpty
                  ? Center(
                      child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 250,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          border: Border.all(color: Colors.black, width: 2)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Empty Cart.",
                            textAlign: TextAlign.center,
                            style:
                                poppinStyle(Colors.black, 30, FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              mainScreenNotifier.pageIndex = 0;
                            },
                            child: Column(
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          topLeft: Radius.circular(10)),
                                      color: Colors.black),
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10.0),
                                      child: Text(
                                        "Let's Add Shoes",
                                        style: poppinStyle(
                                            Colors.white, 20, FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)),
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: cart.length,
                      itemBuilder: (_, index) {
                        SlidableController _slidableController =
                            SlidableController(this);
                        return Slidable(
                          key: const ValueKey(1),
                          controller: _slidableController,
                          direction: Axis.horizontal,
                          closeOnScroll: true,
                          startActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            dismissible: DismissiblePane(
                              onDismissed: () {
                                setState(() {
                                  _cartBox.deleteAt(index);
                                });
                              },
                            ),
                            children: [
                              SlidableAction(
                                autoClose: true,
                                onPressed: (context) => null,
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Swipe to remove',
                              ),
                            ],
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            height: 100,
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        );
                      }),
            );
          }),
        ],
      ),
    );
  }
}
