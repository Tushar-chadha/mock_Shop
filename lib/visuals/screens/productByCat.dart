import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/helper/helperService.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/screens/descriptionScreen.dart';
import 'package:shop/visuals/shared/filterButton.dart';
import 'package:shop/visuals/shared/latestShoeTile.dart';
import 'package:shop/visuals/shared/tabBar.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class ProductByCat extends StatefulWidget {
  final int TabIndex;
  const ProductByCat({super.key, required this.TabIndex});

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat>
    with TickerProviderStateMixin {
  late Future<List<Sneaker>> _male, _female, _kid;
  late TabController ShoeMenuController = TabController(length: 3, vsync: this);
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
    ShoeMenuController.animateTo(widget.TabIndex, curve: Curves.easeInOut);
    getMaleShoe();
    getfemaleShoe();
    getKidShoe();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    ShoeMenuController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AnimationController _animationController = AnimationController(vsync: this);

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
                margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
                    GestureDetector(
                      onTap: () => filter(context),
                      child: const Icon(
                        AntDesign.filter,
                        color: Colors.white,
                        size: 30,
                      ),
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
            padding: const EdgeInsets.only(top: 0),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 2,
            mainAxisSpacing: 10,
            itemCount: shoeData.length,
            scrollDirection: Axis.vertical,
            itemBuilder: ((context, index) {
              final shoeItem = shoeData[index];
              return GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        DescriptionScreen(imgUrls: shoeItem.imageUrl),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 0, bottom: 2, left: 4, right: 6),
                  child: LatestShoesTile(
                      shoeName: shoeItem.name,
                      shoeType: shoeItem.category,
                      imgUrl: shoeItem.imageUrl[1],
                      price: (double.parse(shoeItem.price) * 83.22).round(),
                      id: shoeItem.id),
                ),
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
}
