import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';

import '../../Constant.dart';

class SingleFoodItem extends StatelessWidget {
  FoodModel foodModel;

  SingleFoodItem({
    required this.foodModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>FoodPostDetail(data: foodModel,)));//Open another
      },
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [

                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Hero(
                      tag: foodModel.foodId,
                  child: Container(
                    height: 249,
                      child: Image.asset(foodModel.picture)
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: LikeIcon(),

                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          foodModel.heading,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5,
                        ),
                        child: Row(
                          children: [
                            Text(
                              foodModel.rating.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.star,
                              color: Colors.white,
                              size: 20,
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                          color: Constant.primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        foodModel.restauranName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Rs. ${foodModel.price}",
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                  ),
                  Text(
                    foodModel.numberOfPlacedOrder,
                    style: TextStyle(
                      fontSize: 15,
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


