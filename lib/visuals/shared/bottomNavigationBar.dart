import 'package:flutter/material.dart';
import 'package:shop/visuals/shared/bottomBarButton.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class bottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(8),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 12),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const BottomBarButton(iconName: Octicons.home),
              const BottomBarButton(iconName: Octicons.search),
              FloatingActionButton(
                  splashColor: Colors.black12,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  shape: const CircleBorder(side: BorderSide.none),
                  child: const Icon(
                    Ionicons.add,
                    size: 30,
                  )),
              const BottomBarButton(iconName: Ionicons.cart),
              const BottomBarButton(iconName: Octicons.person),
            ],
          ),
        ),
      ),
    );
  }
}
