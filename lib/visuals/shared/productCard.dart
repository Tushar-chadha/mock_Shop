import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class ProductCard extends StatelessWidget {
 
  final int index;

  const ProductCard({super.key, required this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
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
          borderRadius: BorderRadius.all(
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
                imageUrl: index % 2 == 0
                    ? "https://d326fntlu7tb1e.cloudfront.net/uploads/e32f065b-358a-4d26-a91e-5dcb35bb040f-HP9662_a1.webp"
                    : "https://d326fntlu7tb1e.cloudfront.net/uploads/a767e5dc-0aa6-44bf-9b78-e743b4383672-Q47342_a1.webp",
              ),
            ),
            Text(
              "UltraBoost Shoes",
              style: poppinStyle(Colors.black, 25, FontWeight.bold),
            ),
            Text(
              "Men's Running",
              style: poppinStyle(Colors.black45, 15, FontWeight.normal),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Rs.7500",
                  style: poppinStyle(Colors.black, 20, FontWeight.w500),
                ),
                Row(
                  children: [
                    Text(
                      "Colors",
                      style: poppinStyle(Colors.black45, 15, FontWeight.normal),
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
