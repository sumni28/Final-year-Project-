
import 'package:flutter/material.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantDetailsForUser.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_feedback_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/restaurant_like.dart';
import 'package:provider/provider.dart';


class RestaurantWidget extends StatelessWidget {
  RestaurantModal data;
  RestaurantWidget({
    required this.data,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>RestaurantFeedbackProvider(restaurantId: data.id),
      child: GestureDetector(
        onTap: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>RestaurantDetailsForUser(
        data: data,)));//Open another
      },
        child: Card(
         elevation: 5,

          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Image.network(
                    data.restaurantImage,
                    fit: BoxFit.fill,
                  )),
              SizedBox(
                width: 6,
              ),
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Text(
                          data.location
                      ),
                      Text(
                          data.cusine
                      ),
                    ],
                  ),
                ),
              ),
              RestaurantLikeIcon(),
              SizedBox(
                width: 30,
              )

            ],
          ),
        ),
      ),
    );
  }
}
