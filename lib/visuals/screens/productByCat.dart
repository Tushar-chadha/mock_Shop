import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/shared/tabBar.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key});

  // final Future<List<Sneaker>> male, kid, female;

  // const ProductByCat(
  //     {super.key, required this.male, required this.kid, required this.female});

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController ShoeMenuController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Stack(
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
          ),
          SafeArea(
            right: false,
            left: false,
            bottom: false,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          AntDesign.close,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      const Icon(
                        AntDesign.filter,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                  Gap(10),
                  tabBarWidget(
                    controller: ShoeMenuController,
                  ),
                  const Gap(20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: ShoeMenuController,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: SingleChildScrollView(
                              child: Column(
                            children: List.generate(
                              20,
                              (index) => Container(
                                margin: const EdgeInsets.all(1),
                                color: Colors.blue,
                                width: 10,
                                height: 10,
                              ),
                            ),
                          )),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          // child: ListView(
                          //   children: List.generate(
                          //     20,
                          //     (index) => Container(
                          //       margin: const EdgeInsets.all(10),
                          //       color: Colors.blue,
                          //       width: 10,
                          //       height: 10,
                          //     ),
                          //   ),
                          // ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height,
                          child: ListView(
                            children: List.generate(
                                20,
                                (index) => Container(
                                      margin: const EdgeInsets.all(10),
                                      color: Colors.blue,
                                      width: 10,
                                      height: 10,
                                    )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
