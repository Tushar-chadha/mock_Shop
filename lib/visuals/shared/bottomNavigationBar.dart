import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/controller/mainScreenController.dart';
import 'package:shop/visuals/shared/bottomBarButton.dart';

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
                      ? Ionicons.search
                      : Ionicons.search_outline,
                  onTap: () {
                    return mainScreenNotifier.pageIndex = 1;
                  }),
              CircleAvatar(
                backgroundColor: Colors.white,
                child: BottomBarButton(
                    isIconBlack: true,
                    isSelected: SeletedIndex == 2 ? true : false,
                    iconName: SeletedIndex == 2
                        ? Ionicons.add_circle
                        : Ionicons.add_circle_outline,
                    onTap: () {
                      return mainScreenNotifier.pageIndex = 2;
                    }),
              ),
              BottomBarButton(
                isSelected: SeletedIndex == 3 ? true : false,
                iconName:
                    SeletedIndex == 3 ? Ionicons.cart : Ionicons.cart_outline,
                onTap: () {
                  return mainScreenNotifier.pageIndex = 3;
                },
              ),
              BottomBarButton(
                isSelected: SeletedIndex == 4 ? true : false,
                iconName: SeletedIndex == 4
                    ? Ionicons.person
                    : Ionicons.person_outline,
                onTap: () {
                  return mainScreenNotifier.pageIndex = 4;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
