import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/visuals/shared/appStyles.dart';

Future<dynamic> filter(BuildContext context) {
  List buttonImages = ["adidas", "gucci", "jordan", "nike"];
  double _minValue = 10000;
  double _maxValue = 40000;
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(30))),
    isScrollControlled: true,
    backgroundColor: Color.fromARGB(241, 255, 255, 255),
    barrierColor: Colors.white54,
    isDismissible: true,
    showDragHandle: true,
    elevation: 100,
    enableDrag: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Wrap(
          alignment: WrapAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Filter",
                    style: poppinStyleHeight(
                        Colors.black, 30, FontWeight.bold, 1.2),
                  ),
                ),
                const optionWidget(
                    optionList: ["Male", "Female", "Kids"],
                    optionTitle: "Gender"),
                const optionWidget(
                  optionList: ["Shoes", "Apparel", "Accessories"],
                  optionTitle: "Category",
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Price",
                        style: poppinStyle(Colors.black, 20, FontWeight.bold),
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) => RangeSlider(
                          values: RangeValues(_minValue, _maxValue),
                          min: 0,
                          max: 100000,
                          labels: RangeLabels(
                              _minValue.toString(), _maxValue.toString()),
                          divisions: 1000,
                          activeColor: Colors.black,
                          onChanged: (value) {
                            setState(() {
                              _minValue = value.start;
                              _maxValue = value.end;
                            });
                          }),
                    ),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Brands",
                          style: poppinStyle(Colors.black, 20, FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            buttonImages.length,
                            (index) {
                              return Container(
                                alignment: Alignment.center,
                                height: 80,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10)),
                                  border: Border.all(
                                      width: 1,
                                      color: Colors.black,
                                      style: BorderStyle.solid),
                                ),
                                child: Image(
                                  image: AssetImage(
                                      "assets/images/${buttonImages[index]}.png"),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

class optionWidget extends StatelessWidget {
  final List optionList;
  final String optionTitle;
  const optionWidget({
    super.key,
    required this.optionList,
    required this.optionTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              optionTitle,
              style: poppinStyle(Colors.black, 20, FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              optionList.length,
              (index) {
                return Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 110,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid)),
                  child: Text(
                    optionList[index],
                    style: poppinStyle(Colors.black, 15, FontWeight.normal),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
