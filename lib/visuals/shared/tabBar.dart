import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class tabBarWidget extends StatelessWidget {
  final controller;

  const tabBarWidget({super.key, this.controller});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TabBar(
      indicatorColor: Colors.white,
      unselectedLabelStyle: poppinStyle(Colors.white60, 23, FontWeight.bold),
      labelStyle: poppinStyle(Colors.white, 24, FontWeight.bold),
      tabAlignment: TabAlignment.start,
      isScrollable: true,
      dividerColor: Colors.transparent,
      controller: controller,
      tabs: const [
        Text("Men's Shoes"),
        Text("Women's Shoes"),
        Text("kid's Shoes"),
      ],
    );
  }
}
