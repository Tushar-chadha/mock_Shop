import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:gap/gap.dart';
import 'package:shop/visuals/shared/utilities/appStyles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              image: AssetImage("assets/images/top_image.png"),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.height * 0.015,
              MediaQuery.of(context).size.height * 0.07,
              0,
              0),
          child: Text(
            "My Profile",
            style: poppinStyle(Colors.white, 50, FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              0, MediaQuery.of(context).size.height * 0.25, 0, 0),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: double.maxFinite,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 5,
                      offset: Offset(1, 1),
                      color: Colors.black12,
                      blurRadius: 10)
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              children: [
                Gap(MediaQuery.of(context).size.height * 0.06),
                Text(
                  "John Doe",
                  style: poppinStyle(Colors.black, 25, FontWeight.w600),
                ),
                const info(
                  type: "Email",
                  information: "JohnDoe@Xmail.com",
                ),
                const Gap(15),
                const info(
                  type: "Phone No.",
                  information: "+91 987654321",
                ),
                const Gap(15),
                const info(
                  type: "Address",
                  information: "123 ABC Street",
                ),
                const Gap(15),
                const info(
                  type: "City",
                  information: "Bangalore",
                ),
                const Gap(15),
                const info(
                  type: "State",
                  information: "Karnatka",
                ),
                const Gap(15),
                const info(
                  type: "Country",
                  information: "India",
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.2,
          right: MediaQuery.of(context).size.width * 0.23,
          left: MediaQuery.of(context).size.width * 0.24,
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            radius: 50,
            child: const Icon(
              Fontisto.person,
              color: Colors.black,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }
}

class info extends StatelessWidget {
  const info({
    super.key,
    required this.type,
    required this.information,
  });
  final String type, information;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            type,
            style: poppinStyle(Colors.black, 12, FontWeight.w400),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          width: double.maxFinite,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.grey)),
          child: Text(
            information,
            style: poppinStyle(Colors.black, 15, FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
