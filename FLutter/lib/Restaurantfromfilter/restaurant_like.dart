

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_feedback_provider.dart';
import 'package:provider/provider.dart';

class RestaurantLikeIcon extends StatefulWidget {
  bool isbig;
  RestaurantLikeIcon({
    this.isbig=false,
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantLikeIcon> createState() => _RestaurantLikeIconState();
}

class _RestaurantLikeIconState extends State<RestaurantLikeIcon> {

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantFeedbackProvider>(
      builder: (context,provider,child) {
        return ClipOval(
          child: Container(
            padding: widget.isbig?EdgeInsets.all(4):null,
            color: Colors.white,
            child: provider.loadingLikeRating?
            CircularProgressIndicator():IconButton(
              padding: EdgeInsets.all(8),
              constraints: widget.isbig?BoxConstraints(maxHeight: 48,maxWidth: 48):BoxConstraints(),
              icon: Icon(
                provider.liked?FontAwesomeIcons.solidHeart:FontAwesomeIcons.heart,
                color: provider.liked?Colors.red.shade500:Colors.black,
                size: widget.isbig?null:20,
              ), onPressed: () {
              setState(() {
                provider.addFeedback(enteredLiked: !provider.liked);
              });
            },
            ),
          ),
        );
      }
    );
  }
}