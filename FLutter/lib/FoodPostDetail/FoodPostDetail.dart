import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/Widget/IngredientsContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/IngredientsContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/Menu.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/TimeStartCalorie.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';

class FoodPostDetail extends StatelessWidget {
  FoodModel data;

  FoodPostDetail({
    required this.data, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height;
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: height,
              width: width,
              color: Constant.primaryColor,
              child: Column(
                children: [
                  SizedBox(
                    height: 87,
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      width: width,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Hero(
                                tag: data.foodId,
                                child:data.fromServer?
                                Image.network(
                                    data.picture,
                                  height: 260,
                                  fit: BoxFit.cover,
                                ):
                                Image.asset(
                                  data.picture,
                                  height: 260,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                                data.heading,
                              style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            TimeStar(),
                            SizedBox(
                              height: 20,
                            ),
                            PriceContainer(price: data.price,quantityValue: ValueNotifier(1),),
                            SizedBox(
                              height: 35,
                            ),
                            IngredientsContainer(),
                            SizedBox(
                              height: 35,
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight:Radius.circular(20),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 20,
                left: 22,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      icon: Icon(
                        Icons.keyboard_arrow_left_outlined
                      ), onPressed: () {
                        Navigator.pop(context);
                    },
                    ),

                  ),
                ),
            ),
            Positioned(
                top: 20,
                right: 22,
                child: LikeIcon(
                  isbig: true,

                )
            ),
          ],
        ),
      ),
    );
  }
}




