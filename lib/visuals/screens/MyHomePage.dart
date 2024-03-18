import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    TabController ShoeMenuController = TabController(length: 3, vsync: this);
    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: AssetImage("assets/images/top_image.png"))),
        height: MediaQuery.of(context).size.height * 0.4,
      ),
      SafeArea(
        right: false,
        left: false,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Athletics Shoes Collection",
                style: poppinStyle(Colors.white, 40, FontWeight.bold),
              ),
            ),
            const Gap(20),
            TabBar(
              indicatorColor: Colors.white,
              unselectedLabelStyle:
                  poppinStyle(Colors.white60, 24, FontWeight.bold),
              labelStyle: poppinStyle(Colors.white, 24, FontWeight.bold),
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              dividerColor: Colors.transparent,
              controller: ShoeMenuController,
              tabs: const [
                Text(
                  "Men's Shoes",
                ),
                Text(
                  "Women's Shoes",
                ),
                Text(
                  "Kid's Shoes",
                ),
              ],
            ),
            const Gap(10),
            SizedBox(
              height: 500,
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    child: TabBarView(
                      controller: ShoeMenuController,
                      children: [
                        ShoeListTile(),
                        ShoeListTile(),
                        ShoeListTile(),
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Latest Collection",
                                style: poppinStyle(
                                    Colors.black, 20, FontWeight.bold),
                              ),
                              GestureDetector(
                                onTap: () => print("View All pressed"),
                                child: Text(
                                  "View All",
                                  style: poppinStyle(
                                      Colors.black, 15, FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                          latestCollectionTile()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}

class ShoeListTile extends StatelessWidget {
  const ShoeListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Center(
          child: Container(
              margin: const EdgeInsets.only(left: 20),
              width: 250,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      height: 150,
                      child: const Image(
                        fit: BoxFit.cover,
                        isAntiAlias: true,
                        image: NetworkImage(
                          "https://d326fntlu7tb1e.cloudfront.net/uploads/d60aca33-909b-4df7-9ad7-b75039438e29-GX1398_a1.webp",
                        ),
                      ),
                    ),
                    Text(
                      "Ultra Boost Shoes",
                      style: poppinStyle(Colors.black, 30, FontWeight.bold),
                    ),
                    Text(
                      "Men's Running",
                      style: poppinStyle(Colors.black45, 18, FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Rs.7500",
                          style: poppinStyle(Colors.black, 25, FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              "Colors",
                              style: poppinStyle(
                                  Colors.black45, 15, FontWeight.bold),
                            ),
                            Gap(5),
                            const CircleAvatar(
                              radius: 12,
                              backgroundColor: Colors.black,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )),
        );
      },
      itemCount: 10,
    );
  }
}

class latestCollectionTile extends StatelessWidget {
  const latestCollectionTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.14,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: 10,
          scrollDirection: Axis.horizontal,
          itemBuilder: ((context, index) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(2, 2),
                  )
                ],
                image: const DecorationImage(
                    image: NetworkImage(
                  "https://d326fntlu7tb1e.cloudfront.net/uploads/710d020f-2da8-4e9e-8cff-0c8f24581488-GV6674.webp",
                )),
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: MediaQuery.of(context).size.height * 0.12,
              width: MediaQuery.of(context).size.height * 0.14,
            );
          })),
    );
  }
}
