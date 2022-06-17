import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';

import '../../Constant.dart';

class CafeContainer extends StatelessWidget {

  CafeContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 350,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 18),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Treat yourself right",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Cakes and Bakes SPECIAL",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for(int i=0; i<FoodDummyData.cafeFoodData.length; i++)
                      GestureDetector(
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>
                              FoodPostDetail(
                                  data: FoodDummyData.cafeFoodData[i]
                              )));//Open another
                        },
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                          child: Image.asset(
                            FoodDummyData.cafeFoodData[i].picture,
                            width:200,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                    child: Image.asset("Cafephotos/cafelogo.png"),
                    flex: 3,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                    color: Colors.white.withOpacity(0.4),
                    width: 3,
                  ),

                  Expanded(
                    flex: 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Cakes and Bakes",
                          style: TextStyle(
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "Pastry"
                        ),
                        Text(
                            "Dharan-10, Prithvi chowk"
                        )
                      ],
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


