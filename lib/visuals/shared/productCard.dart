import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Container(
            margin: const EdgeInsets.only(left: 20),
            width: 250,
            height: MediaQuery.of(context).size.height * 0.405,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height * 0.23,
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: true,
                      imageUrl:
                          "https://d326fntlu7tb1e.cloudfront.net/uploads/51ee25c7-46b6-4fd4-bfe0-7dca9a9fd8a9-GX6326_a1.webp",
                    ),
                  ),
                  Text(
                    "Ultra Boost Shoes",
                    style: poppinStyle(Colors.black, 30, FontWeight.bold),
                  ),
                  Text(
                    "Men's Running",
                    style: poppinStyle(Colors.black45, 18, FontWeight.normal),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rs.7500",
                        style: poppinStyle(Colors.black, 25, FontWeight.w500),
                      ),
                      Row(
                        children: [
                          Text(
                            "Colors",
                            style: poppinStyle(
                                Colors.black45, 15, FontWeight.normal),
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
            ));
      },
      itemCount: 10,
    );
  }
}
