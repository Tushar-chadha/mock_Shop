import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/productController.dart';
import 'package:shop/helper/helperService.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class DescriptionScreen extends StatefulWidget {
  final String id, shoeCategory;

  const DescriptionScreen(
      {super.key, required this.id, required this.shoeCategory});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late Future<Sneaker> _sneakerData;

  @override
  void initState() {
    super.initState();
    getShoes();
  }

  void getShoes() {
    if (widget.shoeCategory == "Men's Running") {
      _sneakerData = helper().getMaleShoeById(widget.id);
    } else if (widget.shoeCategory == "Women's Running") {
      _sneakerData = helper().getFemaleShoeById(widget.id);
    } else if (widget.shoeCategory == "Kids' Running") {
      _sneakerData = helper().getKidShoeById(widget.id);
    }
  }

  int currentIndex = 0;
  int isSelectedSize = 20;
  double ratingText = 1.0;
  @override
  Widget build(BuildContext context) {
    var commonHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: FutureBuilder<Sneaker>(
        future: _sneakerData,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (asyncSnapshot.hasError) {
            return Text(asyncSnapshot.error.toString());
          } else {
            return Consumer<ProductNotifier>(
              builder: (BuildContext context, productNotifier, Widget? child) {
                final sneakerData = asyncSnapshot.data!;
                final shoePrice =
                    (double.parse(sneakerData.price) * 83.22).roundToDouble();
                return Container(
                  height: commonHeight,
                  child: Stack(
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: commonHeight * 0.4,
                            child: PageView.builder(
                              onPageChanged: (value) {
                                setState(() {
                                  currentIndex = value;
                                });
                              },
                              pageSnapping: true,
                              itemCount: sneakerData.imageUrl.length,
                              itemBuilder: (_, index) {
                                currentIndex = index;
                                return Container(
                                  color: Colors.transparent,
                                  padding: const EdgeInsets.all(30),
                                  child: CachedNetworkImage(
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    useOldImageOnUrlChange: true,
                                    imageUrl: sneakerData.imageUrl[index],
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                20, commonHeight * 0.068, 20, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: const Icon(
                                    Entypo.chevron_left,
                                    size: 30,
                                  ),
                                ),
                                const Icon(Entypo.dots_three_horizontal,
                                    size: 30)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width * 0.48,
                                commonHeight * 0.315,
                                0,
                                0),
                            child: Container(
                              child: Row(
                                children: List.generate(
                                    sneakerData.imageUrl.length, (index) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 1),
                                    child: CircleAvatar(
                                      radius: currentIndex == index ? 4 : 2,
                                      backgroundColor: currentIndex == index
                                          ? Colors.black
                                          : Colors.black26,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(0, commonHeight * 0.34, 0, 0),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                          width: double.maxFinite,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, -2),
                                  blurRadius: 10,
                                  color: Colors.black12)
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                sneakerData.name,
                                style: poppinStyle(
                                    Colors.black, 35, FontWeight.bold),
                              ),
                              const Gap(5),
                              Row(
                                children: [
                                  Text(
                                    widget.shoeCategory,
                                    style: poppinStyle(Colors.grey.shade400, 20,
                                        FontWeight.bold),
                                  ),
                                  const Gap(5),
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        RatingBar.builder(
                                          glow: false,
                                          itemSize: 20,
                                          initialRating: 1,
                                          updateOnDrag: true,
                                          maxRating: 5,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 1.0),
                                          itemBuilder: (context, index) {
                                            return const Icon(
                                              Icons.star,
                                              color: Colors.black,
                                            );
                                          },
                                          onRatingUpdate: (rating) {
                                            setState(() {
                                              ratingText = rating;
                                            });
                                          },
                                        ),
                                        Text("(${ratingText.toString()})")
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(5),
                              Text(
                                "Rs.${shoePrice.toString()}/-",
                                style: poppinStyle(
                                    Colors.black, 22, FontWeight.w600),
                              ),
                              const Gap(5),
                              Text(
                                "Select sizes",
                                style: poppinStyle(
                                    Colors.black, 20, FontWeight.w700),
                              ),
                              SizedBox(
                                height: 50,
                                width: double.infinity,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isSelectedSize = index;
                                          });
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: isSelectedSize == index
                                                ? Colors.black
                                                : Colors.grey.shade300,
                                          ),
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 10, 10, 0),
                                          child: Text(
                                            sneakerData.sizes[index]["size"]
                                                .toString(),
                                            style: poppinStyle(
                                                isSelectedSize == index
                                                    ? Colors.grey.shade300
                                                    : Colors.black,
                                                15,
                                                FontWeight.bold),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: sneakerData.sizes.length),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        strokeAlign: 0.2,
                                        color: Colors.black12)),
                              ),
                              Text(
                                sneakerData.title,
                                style: poppinStyle(
                                    Colors.black, 25, FontWeight.w700),
                              ),
                              const Gap(5),
                              Container(
                                height: 160,
                                child: SingleChildScrollView(
                                  child: Text(
                                    sneakerData.description,
                                    textAlign: TextAlign.justify,
                                    style: const TextStyle(),
                                  ),
                                ),
                              ),
                              const Gap(20),
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 15,
                                  ),
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  decoration: const BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Text(
                                    "Add to bag",
                                    style: poppinStyle(
                                        Colors.white, 15, FontWeight.bold),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
