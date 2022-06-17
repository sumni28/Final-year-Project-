import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Blog/BlogWidget.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/HomePageFoodPost/SupportLocalWidget.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';

import '../../Constant.dart';

class Newrestaurant extends StatelessWidget {

  Newrestaurant({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "New restaurant in your area",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 9,
            ),
            SizedBox(
              height: 5,
            ),
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  BlogWidget(
                    blogdata: BlogDummyModel(
                      image: "Bloglogo/logo4.png",
                      restaurantName: "Wok asian food",
                      location: "Dharan-16,Prithvi Path",
                      cusine: "Chinese",
                    ),

                  ),
                  BlogWidget(
                    blogdata: BlogDummyModel(
                      image: "Bloglogo/logo5.png",
                      restaurantName: "Good Taste",
                      location: "Dharan-14,Janki line",
                      cusine: "Chinese",
                    ),

                  ),
                  BlogWidget(
                    blogdata: BlogDummyModel(
                      image: "Bloglogo/logo1.png",
                      restaurantName: "Tea & Bee",
                      location: "Dharan-16,Prithvi Path",
                      cusine: "Chinese",
                    ),

                  ),
                  BlogWidget(
                    blogdata: BlogDummyModel(
                      image: "Bloglogo/logo2.png",
                      restaurantName: "Salad Bae",
                      location: "Dharan-16,Prithvi Path",
                      cusine: "Chinese",
                    ),

                  ),
                  BlogWidget(
                    blogdata: BlogDummyModel(
                      image: "Bloglogo/logo3.png",
                      restaurantName: "Grill House",
                      location: "Dharan-16,Prithvi Path",
                      cusine: "Chinese",
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

