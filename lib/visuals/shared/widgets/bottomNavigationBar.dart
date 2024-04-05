import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/controller/mainScreenController.dart';
import 'package:shop/visuals/shared/widgets/bottomBarButton.dart';

class bottomNavBar extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final MainScreenNotifier mainScreenNotifier;
  final int SeletedIndex;

  bottomNavBar(
      {super.key,
      required this.mainScreenNotifier,
      required this.SeletedIndex});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomBarButton(
                  isSelected: SeletedIndex == 0 ? true : false,
                  iconName:
                      SeletedIndex == 0 ? Ionicons.home : Ionicons.home_outline,
                  onTap: () {
                    return mainScreenNotifier.pageIndex = 0;
                  }),
              BottomBarButton(
                  isSelected: SeletedIndex == 1 ? true : false,
                  iconName: SeletedIndex == 1
                      ? Ionicons.md_heart
                      : Ionicons.md_heart_outline,
                  onTap: () {
                    return mainScreenNotifier.pageIndex = 1;
                  }),
              BottomBarButton(
                isSelected: SeletedIndex == 2 ? true : false,
                iconName:
                    SeletedIndex == 2 ? Ionicons.cart : Ionicons.cart_outline,
                onTap: () {
                  return mainScreenNotifier.pageIndex = 2;
                },
              ),
              BottomBarButton(
                isSelected: SeletedIndex == 3 ? true : false,
                iconName: SeletedIndex == 3
                    ? Ionicons.person
                    : Ionicons.person_outline,
                onTap: () {
                  return mainScreenNotifier.pageIndex = 3;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
