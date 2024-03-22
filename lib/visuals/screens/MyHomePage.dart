import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:shop/helper/helperService.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/shared/appStyles.dart';
import 'package:shop/visuals/shared/homeWidget.dart';
import 'package:shop/visuals/shared/productCard.dart';
import 'package:shop/visuals/shared/tabBar.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late Future<List<Sneaker>> _male, _female, _kid;

  void getMaleShoe() {
    _male = helper().getMaleShoesDataFromJson();
  }

  void getfemaleShoe() {
    _female = helper().getWomenShoesDataFromJson();
  }

  void getKidShoe() {
    _kid = helper().getKidsShoesDataFromJson();
  }

  @override
  void initState() {
    super.initState();
    getMaleShoe();
    getfemaleShoe();
    getKidShoe();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    double heightCheck = MediaQuery.of(context).size.height;
    print(heightCheck);
    TabController ShoeMenuController = TabController(length: 3, vsync: this);
    return SizedBox(
      height: MediaQuery.of(context)
          .size
          .height, // to fill the height of the screen
      child: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: AssetImage("assets/images/top_image.png"),
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Gap(20),
                    Text(
                      "Athletics Shoes Collection",
                      style: poppinStyle(Colors.white, 40, FontWeight.bold),
                    ),
                    const Gap(10),
                    tabBarWidget(
                      controller: ShoeMenuController,
                    ),
                    const Gap(10),
                  ],
                ),
              ),
            ),
          ),
          // TabBar And Top section Ended
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.265,
            ),
            child: Container(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: TabBarView(
                controller: ShoeMenuController,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.405,
                    child: HomeWidget(
                      future: _male,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.405,
                    child: HomeWidget(
                      future: _female,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.405,
                    child: HomeWidget(
                      future: _kid,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
