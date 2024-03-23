import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/appStyles.dart';

class LatestShoesTile extends StatefulWidget {
  final shoeName, shoeType, imgUrl, id, price;
  bool isLiked;

  LatestShoesTile({
    super.key,
    required this.shoeName,
    required this.shoeType,
    required this.imgUrl,
    required this.price,
    required this.id,
    this.isLiked = false,
  });
  @override
  State<LatestShoesTile> createState() => _LatestShoesTileState();
}

class _LatestShoesTileState extends State<LatestShoesTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
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
          Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Stack(children: [
        Positioned(
          top: 8,
          right: 8,
          child: GestureDetector(
            onTap: () {
              setState(() {
                widget.isLiked = widget.isLiked ? false : true;
              });
            },
            child: Icon(
              widget.isLiked ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
              size: widget.isLiked ? 22 : 20,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.height * 0.17,
              child: CachedNetworkImage(
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                  useOldImageOnUrlChange: true,
                  imageUrl: widget.imgUrl.toString()),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.shoeName,
                  style: poppinStyle(Colors.black, 25, FontWeight.bold),
                ),
                Text(
                  "Rs." + widget.price.toString(),
                  style: poppinStyle(Colors.black, 20, FontWeight.w600),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
