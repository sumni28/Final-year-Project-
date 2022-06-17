import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/HomePageFoodPost/SupportLocalWidget.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';

import '../../Constant.dart';

class SupportlocalContainer extends StatelessWidget {

  SupportlocalContainer({
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
              "Support Local",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Text(
              "local swad",
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
                    image: "LocalFoodPhotos/Jholmomo.PNG",
                    heading: "Jhol Momo",
                    subheading: "Price: 140",
                        restaurantName: "WOrkshop Eatery",
                    ),

                  ),
                  SupportLocalwidget(data: SupportLocalModel(
                      image: "LocalFoodPhotos/Sheyfaley.PNG",
                      heading: "Sheyfaley",
                      subheading: "Price: 60",
                      restaurantName: "Happy Tummy"
                  ), )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

