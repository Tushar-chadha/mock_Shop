import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionScreen extends StatefulWidget {
  final List<String> imgUrls;
  final String shoeName, shoeCategory;
  final shoePrice;
  final List shoeSizes;

  DescriptionScreen(
      {super.key,
      required this.imgUrls,
      required this.shoeName,
      required this.shoeCategory,
      required this.shoePrice,
      required this.shoeSizes});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    var commonHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Container(
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
                    itemCount: widget.imgUrls.length,
                    itemBuilder: (_, index) {
                      currentIndex = index;
                      print(currentIndex);
                      return Container(
                        color: Colors.transparent,
                        padding: const EdgeInsets.all(30),
                        child: CachedNetworkImage(
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                          useOldImageOnUrlChange: true,
                          imageUrl: widget.imgUrls[index],
                        ),
                      );
                    },
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
                      children: List.generate(widget.imgUrls.length, (index) {
                        print(currentIndex);
                        print(index);
                        print("hahahahah");
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 1),
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
              padding: EdgeInsets.fromLTRB(0, commonHeight * 0.34, 0, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 30, 0, 0),
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, -3),
                        blurRadius: 5,
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
                    Text(widget.shoeName),
                    Text(widget.shoeCategory),
                    Text(widget.shoePrice.toString()),
                    const Text("Select sizes"),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: CircleAvatar(
                                backgroundColor: Colors.grey.shade300,
                                child: Text(
                                    widget.shoeSizes[index]["size"].toString()),
                              ),
                            );
                          },
                          itemCount: widget.shoeSizes.length),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
