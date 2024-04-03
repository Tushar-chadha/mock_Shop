import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/cartProvider.dart';
import 'package:shop/controller/favController.dart';
import 'package:shop/controller/productController.dart';
import 'package:shop/helper/helperService.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';
import 'package:shop/visuals/shared/widgets/action_chip_for_sizes.dart';
import 'package:shop/visuals/shared/widgets/checkout_button.dart';
import 'package:toast/toast.dart';

class DescriptionScreen extends StatefulWidget {
  final String id, shoeCategory;

  const DescriptionScreen(
      {Key? key, required this.id, required this.shoeCategory})
      : super(key: key);

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  late Future<Sneaker> _sneakerData;
  int currentIndex = 0;
  double ratingText = 1.0;
  int quantity = 0;

  final _cartBox = Hive.box("cart_box");

  Future<void> _createCart(Map<String, dynamic> newCart) async {
    await _cartBox.add(newCart); //cart shared preferences
    print(_cartBox.values);
  }

  late FavNotifier _favNotifier;
  @override
  void initState() {
    super.initState();
    getShoes();
    _favNotifier = Provider.of<FavNotifier>(context, listen: false);
    _favNotifier.getFav(); // Call getFav() when DescriptionScreen initializes
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

  final toastContext = ToastContext();
  @override
  Widget build(BuildContext context) {
    toastContext.init(context);
    var commonHeight = MediaQuery.of(context).size.height;
    return Consumer3<ProductNotifier, CartNotifier, FavNotifier>(builder:
        (BuildContext context, productNotifier, cartNotifier, favNotifier,
            Widget? child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          productNotifier.unSelectALl();
          cartNotifier.setQuantity = 0;
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFE2E2E2),
          body: FutureBuilder<Sneaker>(
            future: _sneakerData,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (asyncSnapshot.hasError) {
                return Text(asyncSnapshot.error.toString());
              } else {
                final sneakerData = asyncSnapshot.data!;
                final shoePrice =
                    (double.parse(sneakerData.price) * 83.22).roundToDouble();
                return Stack(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: commonHeight * 0.4,
                          child: PageView.builder(
                            onPageChanged: (value) {
                              productNotifier.SetActivePage = value;
                              currentIndex = productNotifier.activePage;
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
                              20, commonHeight * 0.065, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                  productNotifier.unSelectALl();
                                  cartNotifier.setQuantity = 0;
                                },
                                child: const Icon(
                                  Entypo.chevron_left,
                                  size: 30,
                                ),
                              ),
                              const Icon(Entypo.dots_three_horizontal,
                                  size: 30),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              20, commonHeight * 0.115, 20, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 10,
                                width: 10,
                              ),
                              GestureDetector(
                                  onTap: () async {
                                    if (favNotifier.id
                                        .contains(sneakerData.id)) {
                                      for (int i = 0;
                                          i < favNotifier.fav.length;
                                          i++) {
                                        if (favNotifier.fav[i]["id"] ==
                                            sneakerData.id) {
                                          Future.microtask(() {
                                            favNotifier.delFav(
                                                favNotifier.fav[i]["key"],
                                                sneakerData.id);
                                          });
                                          break;
                                        }
                                      }
                                    } else {
                                      favNotifier.createFavBox({
                                        "id": sneakerData.id,
                                        "name": sneakerData.name,
                                        "category": sneakerData.category,
                                        "imgUrl": sneakerData.imageUrl[1],
                                        "price": shoePrice,
                                      });
                                    }
                                  },
                                  child: Icon(
                                      favNotifier.id.contains(sneakerData.id)
                                          ? MaterialCommunityIcons.heart
                                          : MaterialCommunityIcons
                                              .heart_outline,
                                      size: 30)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.48,
                              commonHeight * 0.315,
                              0,
                              0),
                          child: Row(
                            children: List.generate(sneakerData.imageUrl.length,
                                (index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: CircleAvatar(
                                  radius: currentIndex == index ? 4 : 2,
                                  backgroundColor: currentIndex == index
                                      ? Colors.black
                                      : Colors.black26,
                                ),
                              );
                            }),
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
                        child: ListView(
                          padding: EdgeInsets.zero,
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
                                        itemPadding: const EdgeInsets.symmetric(
                                            horizontal: 1.0),
                                        itemBuilder: (context, index) {
                                          return const Icon(
                                            Icons.star,
                                            color: Colors.black,
                                          );
                                        },
                                        onRatingUpdate: (rating) {
                                          productNotifier.updateRating(rating);
                                          ratingText = productNotifier.rating;
                                        },
                                      ),
                                      Text("(${ratingText.toString()})")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Gap(5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Rs.${shoePrice.toString()}/-",
                                  style: poppinStyle(
                                      Colors.black, 22, FontWeight.w600),
                                ),
                                Builder(builder: (context) {
                                  quantity = cartNotifier.quantityGetter;
                                  return Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          cartNotifier.setQuantity =
                                              cartNotifier.quantityGetter + 1;
                                        },
                                        child: const Icon(
                                          Icons.add_box,
                                          size: 30,
                                        ),
                                      ),
                                      Text(
                                        "Qty:$quantity",
                                        style: poppinStyle(
                                            Colors.black, 22, FontWeight.w600),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          cartNotifier.setQuantity =
                                              cartNotifier.quantityGetter == 0
                                                  ? cartNotifier.setQuantity = 0
                                                  : cartNotifier
                                                          .quantityGetter -
                                                      1;
                                        },
                                        child: const Icon(
                                          AntDesign.minussquare,
                                          size: 29,
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      strokeAlign: 0.2, color: Colors.black12)),
                            ),
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
                                itemCount: productNotifier.getShoeSize.length,
                                itemBuilder: (context, index) {
                                  return actionChipForSizes(
                                    sizes: productNotifier.getShoeSize[index],
                                    index: index,
                                    productNotifier: productNotifier,
                                  );
                                }, //ShoeSizeWidget
                              ),
                            ),
                            const Gap(15),
                            CheckoutButton(
                              sizeSelected: productNotifier.finalShoeSizeGetter,
                              addDataToHiveBox: () {
                                if (quantity == 0) {
                                  Toast.show(
                                    "Add quantity to add to cart.",
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom,
                                  );
                                } else {
                                  productNotifier.unSelectALl();
                                  cartNotifier.setQuantity = 0;
                                  Toast.show("Item added to cart Successfully",
                                      textStyle: poppinStyle(
                                          Colors.white, 15, FontWeight.normal),
                                      duration: Toast.lengthShort,
                                      gravity: Toast.bottom,
                                      backgroundColor: Colors.black);
                                  return _createCart(
                                    {
                                      "id": sneakerData.id,
                                      "name": sneakerData.name,
                                      "category": sneakerData.category,
                                      "price": shoePrice,
                                      "size":
                                          productNotifier.finalShoeSizeGetter,
                                      "imgUrl": sneakerData.imageUrl[1],
                                      "quantity": quantity,
                                    },
                                  );
                                }
                              },
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      strokeAlign: 0.2, color: Colors.black12)),
                            ),
                            Text(
                              sneakerData.title,
                              style: poppinStyle(
                                  Colors.black, 25, FontWeight.w700),
                            ),
                            const Gap(5),
                            Text(
                              sneakerData.description,
                              textAlign: TextAlign.justify,
                              style: const TextStyle(),
                            ),
                            const Gap(20),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      );
    });
  }
}
