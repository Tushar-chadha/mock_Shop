import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:shop/helper/helperService.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/shared/homeWidget.dart';
import 'package:shop/visuals/shared/productCard.dart';
import 'package:shop/visuals/shared/staggeredTile.dart';
import 'package:shop/visuals/shared/tabBar.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key});

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
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
    TabController ShoeMenuController = TabController(length: 3, vsync: this);
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
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
            ),
            SafeArea(
              right: false,
              left: false,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                child: Row(
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
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.13),
              child: tabBarWidget(
                controller: ShoeMenuController,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.18,
              ),
              child: TabBarView(
                controller: ShoeMenuController,
                children: [
                  futureBuilder(_male),
                  futureBuilder(_female),
                  futureBuilder(_kid),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget futureBuilder(Future<List<Sneaker>> future) {
  return FutureBuilder<List<Sneaker>>(
    future: future,
    builder: (context, asyncSnapshot) {
      if (asyncSnapshot.connectionState == ConnectionState.waiting) {
        return const CircularProgressIndicator();
      } else if (asyncSnapshot.hasError) {
        return Text(asyncSnapshot.error.toString());
      } else {
        final List<Sneaker> shoeData = asyncSnapshot.data!;
        return StaggeredGridView.countBuilder(
          padding: EdgeInsets.only(top: 0),
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 10,
          itemCount: shoeData.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ((context, index) {
            final shoeItem = shoeData[index];
            return Container(
              padding:
                  const EdgeInsets.only(top: 0, bottom: 2, left: 4, right: 6),
              child: StaggeredTitle(
                  shoeName: shoeItem.name,
                  shoeType: shoeItem.category,
                  imgUrl: shoeItem.imageUrl[1],
                  price: (double.parse(shoeItem.price) * 83.22).round(),
                  id: shoeItem.id),
            );
          }),
          staggeredTileBuilder: (index) => StaggeredTile.extent(
              (index % 2 == 0) ? 1 : 1,
              (index % 3 == 1 || index % 6 == 3)
                  ? MediaQuery.of(context).size.height * 0.33
                  : MediaQuery.of(context).size.height * 0.30),
        );
      }
    },
  );
}
