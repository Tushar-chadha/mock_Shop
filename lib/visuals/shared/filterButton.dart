import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:shop/visuals/shared/appStyles.dart';

Future<dynamic> filter(BuildContext context) {
  double _minValue = 10000;
  double _maxValue = 40000;
  return showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: true,
    elevation: 100,
    enableDrag: true,
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.only(top: 5, bottom: 5),
                      child: const Icon(AntDesign.minus,
                          size: 50, color: Colors.black26)),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Text(
                      "Filter",
                      style: poppinStyleHeight(
                          Colors.black, 30, FontWeight.bold, 1.2),
                    ),
                  ),
                  optionWidget(
                      optionList: ["Male", "Female", "Kids"],
                      optionTitle: "Gender"),
                  optionWidget(
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
                            style:
                                poppinStyle(Colors.black, 20, FontWeight.bold),
                          ),
                        ),
                        BrandOptions(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

class optionWidget extends StatefulWidget {
  final List optionList;
  final String optionTitle;

  optionWidget({
    super.key,
    required this.optionList,
    required this.optionTitle,
  });

  @override
  State<optionWidget> createState() => _optionWidgetState();
}

class _optionWidgetState extends State<optionWidget> {
  Set<int> selectedIndices = Set();

  @override
  Widget build(BuildContext context) {
    print(widget.optionTitle + selectedIndices.toString());
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
              widget.optionTitle,
              style: poppinStyle(Colors.black, 20, FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.optionList.length,
              (index) {
                final isSelected = selectedIndices.contains(index);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedIndices.remove(index);
                      } else {
                        selectedIndices.add(index);
                      }
                    });
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 50,
                    width: 110,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(
                            width: 1,
                            color: isSelected
                                ? Colors.black
                                : Colors.grey.shade400,
                            style: BorderStyle.solid)),
                    child: Text(
                      widget.optionList[index],
                      style: poppinStyle(
                          isSelected ? Colors.black : Colors.grey.shade600,
                          15,
                          FontWeight.normal),
                    ),
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

class BrandOptions extends StatefulWidget {
  @override
  State<BrandOptions> createState() => _BrandOptionsState();
}

class _BrandOptionsState extends State<BrandOptions> {
  Set<int> selectedIndices = Set();
  List buttonImages = ["adidas", "gucci", "jordan", "nike"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(
          buttonImages.length,
          (index) {
            final isSelected = selectedIndices.contains(index);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedIndices.remove(index);
                  } else {
                    selectedIndices.add(index);
                  }
                });
              },
              child: Container(
                alignment: Alignment.center,
                height: 80,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black : Colors.transparent,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    width: 1,
                    color: isSelected ? Colors.black : Colors.grey,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Image(
                  color: isSelected ? Colors.grey.shade300 : Colors.black,
                  image: AssetImage("assets/images/${buttonImages[index]}.png"),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
