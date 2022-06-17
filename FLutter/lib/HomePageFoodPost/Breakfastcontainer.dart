import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/HomePageFoodPost/SupportLocalWidget.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';

import '../../Constant.dart';

class Breakfastcontainer extends StatelessWidget {

  Breakfastcontainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Now Serving Breakfast",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "Start your morning right",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SupportLocalwidget(
                    data: SupportLocalModel(
                      image: "BreakfastPhotos/beigals.JPG",
                      heading: "beigals",
                      subheading: "Price: 140",
                      restaurantName: "Kamana Bakery",
                    ),

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SupportLocalwidget(data: SupportLocalModel(
                      image: "BreakfastPhotos/crossant.JPG",
                      heading: "Crossaint",
                      subheading: "Price: 160",
                      restaurantName: "Anzees Bakery"
                  ), ),
                  SizedBox(
                    width: 10,
                  ),
                  SupportLocalwidget(data: SupportLocalModel(
                      image: "BreakfastPhotos/breadegg.JPG",
                      heading: "Egg bread",
                      subheading: "Price: 160",
                      restaurantName: "Nirbana Bakery and bristo"
                  ), ),
                  SizedBox(
                    width: 10,
                  ),
                  SupportLocalwidget(data: SupportLocalModel(
                      image: "BreakfastPhotos/crossaint.JPG",
                      heading: "Croosaint",
                      subheading: "Price: 240",
                      restaurantName: "Whimsical Cafe"
                  ), ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

