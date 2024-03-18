import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/appStyles.dart';
import 'package:shop/visuals/shared/homeWidget.dart';
import 'package:shop/visuals/shared/productCard.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
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
                    Gap(30),
                    Text(
                      "Athletics Shoes Collection",
                      style: poppinStyle(Colors.white, 40, FontWeight.bold),
                    ),
                    const Gap(10),
                    TabBar(
                      indicatorColor: Colors.white,
                      unselectedLabelStyle:
                          poppinStyle(Colors.white60, 23, FontWeight.bold),
                      labelStyle:
                          poppinStyle(Colors.white, 24, FontWeight.bold),
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      dividerColor: Colors.transparent,
                      controller: ShoeMenuController,
                      tabs: const [
                        Text("Men's Shoes"),
                        Text("Women's Shoes"),
                        Text("kid's Shoes"),
                      ],
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
                top: MediaQuery.of(context).size.height * 0.295),
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: TabBarView(
                controller: ShoeMenuController,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.405,
                    child: HomeWidget(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.405,
                    child: HomeWidget(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.405,
                    child: HomeWidget(),
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


// class latestCollectionTile extends StatelessWidget {
//   const latestCollectionTile({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: MediaQuery.of(context).size.height * 0.14,
//       width: MediaQuery.of(context).size.width,
//       child: ListView.builder(
//           itemCount: 10,
//           scrollDirection: Axis.horizontal,
//           itemBuilder: ((context, index) {
//             return Container(
//               decoration: BoxDecoration(
              
//                 ],
//                 color: Colors.white,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//               ),
//               margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//               height: MediaQuery.of(context).size.height * 0.12,
//               width: MediaQuery.of(context).size.height * 0.14,
//               child: CachedNetworkImage(
//                 imageUrl:
//                     "https://d326fntlu7tb1e.cloudfront.net/uploads/710d020f-2da8-4e9e-8cff-0c8f24581488-GV6674.webp",
//               ),
//             );
//           })),
//     );
//   }
// }
