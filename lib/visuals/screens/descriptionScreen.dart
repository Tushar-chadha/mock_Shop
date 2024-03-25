import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionScreen extends StatelessWidget {
  final List<String> imgUrls;

  DescriptionScreen({super.key, required this.imgUrls});
  @override
  Widget build(BuildContext context) {
    var commonHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFFE2E2E2),
      body: Container(
        height: commonHeight,
        child: Stack(
          children: [
            Container(
              height: commonHeight * 0.4,
              child: PageView.builder(
                pageSnapping: true,
                itemCount: imgUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.all(30),
                    child: CachedNetworkImage(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      useOldImageOnUrlChange: true,
                      imageUrl: imgUrls[index],
                    ),
                  );
                },
              ),
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
