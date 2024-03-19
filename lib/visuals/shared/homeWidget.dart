import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/appLayout.dart';
import 'package:shop/visuals/shared/appStyles.dart';
import 'package:shop/visuals/shared/productCard.dart';

class HomeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(AppLayout.getSize(context, 320));
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Column(children: [
        SizedBox(
          height: AppLayout.getSize(context, 320),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 10,
            itemBuilder: (context, index) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: ProductCard(
                    index: index,
                  ));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Latest Collection",
                    style: poppinStyle(Colors.black, 20, FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () => print("View All pressed"),
                    child: Text(
                      "View All",
                      style: poppinStyle(Colors.black, 15, FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const Gap(5),
              SizedBox(
                height: AppLayout.getSize(context, 100),
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.fromLTRB(5, 0, 10, 0),
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
                          Radius.circular(15),
                        ),
                      ),
                      child: CachedNetworkImage(
                          imageUrl:
                              "https://d326fntlu7tb1e.cloudfront.net/uploads/d60aca33-909b-4df7-9ad7-b75039438e29-GX1398_a1.webp"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
