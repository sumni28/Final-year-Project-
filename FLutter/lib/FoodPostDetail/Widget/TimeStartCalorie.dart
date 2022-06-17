import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TimeStar extends StatelessWidget {
  final String startingEnding;
  final String rating;
  final String heart;
  const TimeStar({
    this.startingEnding="",
    this.rating="0.0",
    this.heart="0",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(

        children: [

         Row(
            children: [
              Spacer(),
              Icon(
                FontAwesomeIcons.star, color: Colors.yellow.withOpacity(0.9),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  rating
              ),
              SizedBox(width: 20,),
              Icon(
                FontAwesomeIcons.solidHeart, color: Colors.red,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                  heart
              ),
              Spacer(),

            ],
          ),
          startingEnding==""?SizedBox():SizedBox(height: 10,),
          startingEnding==""?SizedBox():Row(
            children: [
              Spacer(),
              Icon(
                FontAwesomeIcons.clock, color: Colors.lightBlueAccent,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                startingEnding,
                textAlign: TextAlign.center,
              ),
              Spacer(),
            ],
          ),
          SizedBox(
            height: 10,
          ),




        ],
      );
  }
}
