import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DescriptionScreen extends StatefulWidget {
  final List<String> imgUrls;

  DescriptionScreen({super.key, required this.imgUrls});

  @override
  State<DescriptionScreen> createState() => _DescriptionScreenState();
}

class _DescriptionScreenState extends State<DescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    var commonHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: Container(
        height: commonHeight,
        child: Stack(
          children: [
            Stack(
              children: [
                Container(
                  height: commonHeight * 0.4,
                  child: PageView.builder(
                    pageSnapping: true,
                    itemCount: widget.imgUrls.length,
                    itemBuilder: (context, index) {
                      setState(() {
                        currentIndex = index;
                      });

                      return Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.all(30),
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
                      MediaQuery.of(context).size.width * 0.45,
                      commonHeight * 0.315,
                      0,
                      0),
                  child: Container(
                    child: Row(
                      children: List.generate(
                          widget.imgUrls.length,
                          (index) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                child: CircleAvatar(
                                  radius: 4,
                                  backgroundColor: currentIndex == index
                                      ? Colors.black
                                      : Colors.amberAccent,
                                ),
                              )),
                    ),
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, commonHeight * 0.34, 0, 0),
              child: Container(
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
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
