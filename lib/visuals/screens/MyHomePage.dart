import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController ShoeMenuController = TabController(length: 3, vsync: this);
    return Stack(children: [
      Container(
        color: Colors.black,
        height: 300,
      ),
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Athletics Shoes Collection",
                style: poppinStyle(Colors.white, 40, FontWeight.bold),
              ),
              TabBar(
                controller: ShoeMenuController,
                labelColor: Colors.white,
                tabs: [
                  Text("Men's Shoes"),
                  Text("Women's Shoes"),
                  Text("kid's Shoes"),
                ],
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
