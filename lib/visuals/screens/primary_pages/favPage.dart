import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:shop/controller/favController.dart';
import 'package:shop/controller/mainScreenController.dart';
import 'package:shop/visuals/screens/secondary_pages/descriptionScreen.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';

class FavPage extends StatefulWidget {
  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  late FavNotifier _favNotifier;

  @override
  void initState() {
    super.initState();
    _favNotifier = Provider.of<FavNotifier>(context, listen: false);
    _favNotifier.getFav(); // Call getFav() when DescriptionScreen initializes
  }

  @override
  Widget build(BuildContext context) {
    MainScreenNotifier mainScreenNotifier =
        Provider.of<MainScreenNotifier>(context, listen: true);
    List fav = _favNotifier.fav;

    var commonSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: commonBackground,
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                commonSize.height * 0.025, commonSize.height * 0.07, 0, 0),
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                filterQuality: FilterQuality.high,
                image: AssetImage("assets/images/top_image.png"),
              ),
            ),
            child: Text(
              textAlign: TextAlign.start,
              "WishList",
              style: poppinStyle(Colors.white, 55, FontWeight.bold),
            ),
          ),
          fav.isEmpty
              ? Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(50),
                      Text(
                        "Loved It?",
                        textAlign: TextAlign.center,
                        style: poppinStyle(Colors.black, 40, FontWeight.bold),
                      ),
                      const Gap(5),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black87),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {
                          mainScreenNotifier.pageIndex = 0;
                        },
                        child: Text(
                          "Add it to Wishlist",
                          style: poppinStyle(Colors.white, 22, FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(top: commonSize.height * 0.15),
                  child: SizedBox(
                    height: commonSize.height,
                    width: double.maxFinite,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: fav.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => DescriptionScreen(
                                        id: fav[index]["id"],
                                        shoeCategory: fav[index]["category"])));
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                height: commonSize.height * 0.13,
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      right: 20,
                                      bottom: 2,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _favNotifier.delFav(
                                                fav[index]["key"],
                                                fav[index]["id"]);
                                          });
                                        },
                                        child: const Icon(
                                          MaterialCommunityIcons.heart,
                                          color: Colors.red,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        CachedNetworkImage(
                                            imageUrl: fav[index]['imgUrl']),
                                        const Gap(10),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Text(
                                              fav[index]['name'],
                                              style: poppinStyle(Colors.black,
                                                  20, FontWeight.bold),
                                            ),
                                            Text(
                                              fav[index]['category'],
                                              style: poppinStyle(
                                                  Colors.grey.shade400,
                                                  16,
                                                  FontWeight.w600),
                                            ),
                                            Text(
                                              "Rs.${fav[index]['price']}",
                                              style: poppinStyle(Colors.black,
                                                  18, FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                )
        ],
      ),
    );
  }
}
