import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';

class ProductCard extends StatefulWidget {
  final shoeName, shoeType, imgUrl, id, price;

  ProductCard({
    super.key,
    required this.shoeName,
    required this.shoeType,
    required this.imgUrl,
    required this.price,
    required this.id,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 15, 0),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
              height: MediaQuery.of(context).size.height * 0.20,
              child: CachedNetworkImage(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  useOldImageOnUrlChange: true,
                  imageUrl: widget.imgUrl.toString()),
            ),
            Text(
              widget.shoeName,
              style: poppinStyle(Colors.black, 25, FontWeight.bold),
            ),
            Text(
              widget.shoeType,
              style: poppinStyle(Colors.black45, 15, FontWeight.normal),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs." + widget.price.toString(),
                  style: poppinStyle(Colors.black, 20, FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      "Colors",
                      style:
                          poppinStyle(Colors.black45, 15, FontWeight.normal),
                    ),
                    const Gap(5),
                    const CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
