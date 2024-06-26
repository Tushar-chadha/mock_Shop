import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/productController.dart';
import 'package:shop/model/sneakerModel.dart';
import 'package:shop/visuals/screens/secondary_pages/descriptionScreen.dart';
import 'package:shop/visuals/screens/secondary_pages/productByCat.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';
import 'package:shop/visuals/shared/widgets/productCard.dart';

class HomeWidget extends StatefulWidget {
  final int TabIndex;
  final Future<List<Sneaker>> future;

  const HomeWidget({super.key, required this.future, required this.TabIndex});
  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.400,
                  child: FutureBuilder<List<Sneaker>>(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                          style: poppinStyle(Colors.black, 15, FontWeight.bold),
                        );
                      } else {
                        final shoelist = snapshot.data;
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.400,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: shoelist!.length,
                              itemBuilder: (context, index) {
                                final shoeData = shoelist[index];
                                return GestureDetector(
                                  onTap: () {
                                    final sizes = shoeData.sizes;
                                    productNotifier.SetShoeSize = sizes;
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return DescriptionScreen(
                                            id: shoeData.id,
                                            shoeCategory: shoeData.category,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(2, 0, 0, 0),
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: ProductCard(
                                      id: 0,
                                      shoeName: shoeData.name,
                                      imgUrl: shoeData.imageUrl[0],
                                      shoeType: shoeData.category,
                                      price:
                                          (double.parse(shoeData.price) * 83.22)
                                              .round(),
                                    ),
                                  ),
                                );
                              }),
                        );
                      }
                    },
                    future: widget.future,
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Latest Collection",
                          style: poppinStyle(Colors.black, 20, FontWeight.bold),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductByCat(
                                TabIndex: widget.TabIndex,
                              ), // by category
                            ),
                          ),
                          child: Text(
                            "View All",
                            style:
                                poppinStyle(Colors.black, 15, FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<List<Sneaker>>(
                    future: widget.future,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator.adaptive();
                      } else if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                          style: poppinStyle(Colors.black, 15, FontWeight.bold),
                        );
                      } else {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height > 900
                              ? 120
                              : 100,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final shoeData = snapshot.data![index];
                              return GestureDetector(
                                onTap: () {
                                  // productNotifier.SetShoeSize = shoeData.sizes;

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DescriptionScreen(
                                          id: shoeData.id,
                                          shoeCategory: shoeData.category,
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  margin:
                                      const EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 3,
                                        offset: const Offset(2, 2),
                                      ),
                                    ],
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: CachedNetworkImage(
                                      filterQuality: FilterQuality.high,
                                      imageUrl:
                                          snapshot.data![index].imageUrl[1]),
                                ),
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
