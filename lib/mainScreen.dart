import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/mainScreenController.dart';
import 'package:shop/visuals/screens/MyHomePage.dart';
import 'package:shop/visuals/screens/cart_page.dart';
import 'package:shop/visuals/screens/profile.dart';
import 'package:shop/visuals/screens/search_page.dart';
import 'package:shop/visuals/shared/bottomBarButton.dart';
import 'package:shop/visuals/shared/bottomNavigationBar.dart';

class mainScreen extends StatefulWidget {
  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  List<Widget> pageToDisplay = [
    MyHomePage(),
    SearchPage(),
    MyHomePage(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
      builder: (context, mainScreenNotifier, child) {
        int currentIndex = mainScreenNotifier.pageIndex;
        if (kDebugMode) {
          print("current Page Index " + currentIndex.toString());
        }
        return Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          bottomNavigationBar: SafeArea(
              top: false,
              child: bottomNavBar(
                mainScreenNotifier: mainScreenNotifier,
                SeletedIndex: currentIndex,
              )),
          body: pageToDisplay[currentIndex],
        );
      },
    );
  }
}
