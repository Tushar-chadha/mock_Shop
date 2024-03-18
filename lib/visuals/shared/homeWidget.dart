import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/appStyles.dart';
import 'package:shop/visuals/shared/productCard.dart';

class HomeWidget extends StatelessWidget {
  final BuildContext context1;

  const HomeWidget({super.key, required this.context1});
  @override
  Widget build(BuildContext context1) {
    return SizedBox(
      height: MediaQuery.of(context1).size.height,
      child: Column(children: [
        Container(
          color: Colors.amberAccent,
          height: MediaQuery.of(context1).size.height * 0.405,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
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
            ],
          ),
        ),
      ]),
    );
  }
}
