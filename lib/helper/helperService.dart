import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:shop/model/sneakerModel.dart';

class helper {
  Future<List<Sneaker>> getMaleShoesDataFromJson() async {
    final response = await rootBundle.loadString("assets/json/men_shoes.json");
    final ShoeList = sneakerFromJson(
        response); //  sneaker from json is a method that gets data into list from json

    return ShoeList;
  }

  Future<List<Sneaker>> getWomenShoesDataFromJson() async {
    final response =
        await rootBundle.loadString("assets/json/women_shoes.json");
    final ShoeList = sneakerFromJson(
        response); //  sneaker from json is a method that gets data into list from json

    return ShoeList;
  }

  Future<List<Sneaker>> getKidsShoesDataFromJson() async {
    final response = await rootBundle.loadString("assets/json/kids_shoes.json");
    final ShoeList = sneakerFromJson(
        response); //  sneaker from json is a method that gets data into list from json

    return ShoeList;
  }

  Future<Sneaker> getMaleShoeById(String id) async {
    final response = await rootBundle.loadString("assets/json/men_shoes.json");
    final ShoeList = sneakerFromJson(
        response); //  sneaker from json is a method that gets data into list from json
    final shoe = ShoeList.firstWhere((sneaker) => sneaker.id == id);
    return shoe;
  }

  Future<Sneaker> getFemaleShoeById(String id) async {
    final response =
        await rootBundle.loadString("assets/json/women_shoes.json");
    final ShoeList = sneakerFromJson(
        response); //  sneaker from json is a method that gets data into list from json
    final shoe = ShoeList.firstWhere((sneaker) => sneaker.id == id);

    return shoe;
  }

  Future<Sneaker> getKidShoeById(String id) async {
    final response = await rootBundle.loadString("assets/json/kids_shoes.json");
    final ShoeList = sneakerFromJson(
        response); //  sneaker from json is a method that gets data into list from json
    final shoe = ShoeList.firstWhere((sneaker) => sneaker.id == id);

    return shoe;
  }

  final _favBox = Hive.box("fav_box");

  Future<void> createFavBox(Map<String, dynamic> newFav) async {
    await _favBox.add(newFav); //cart shared preferences
    print(_favBox.values);
  }
}
