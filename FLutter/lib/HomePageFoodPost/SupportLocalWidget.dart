import 'package:flutter/material.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/Model/FoodModel.dart';

class SupportLocalModel {
  String image, heading, subheading, restaurantName;
  SupportLocalModel({
    required this.image,
    required this.heading,
    required this.subheading,
    required this.restaurantName,
  });
}


class SupportLocalwidget extends StatelessWidget {
  SupportLocalModel data;
  SupportLocalwidget({
    required this.data,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=>
            FoodPostDetail(
                data:  FoodModel(
                    name: data.heading,
                    picture: data.image,
                    heading: data.heading,
                    restauranName: data.restaurantName,
                    cusine: data.heading,
                    rating: 5,
                    price: 150,
                    numberOfPlacedOrder: "more than 10",
                    time: "10am to 7pm",
                    foodId: "101")

            )));//Open another
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        width: 200,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2), width: 4),
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: SizedBox(
                  height: 175,
                  width: double.infinity,
                  child: Image.asset(
                    data.image,
                    fit: BoxFit.fill,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    data.heading,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                      data.subheading,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Divider(
                    thickness: 5,
                    color: Colors.grey.withOpacity(0.3),
                  ),
                  Text(
                      data.restaurantName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
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
