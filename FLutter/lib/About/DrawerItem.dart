import 'package:flutter/material.dart';
import 'package:kkhaney/About/AboutPage.dart';
import 'package:kkhaney/Constant.dart';

class CustomCard extends StatelessWidget {
  final IconData iconValue;
  final String value;
  final Function() onPressed;
  const CustomCard({
    Key? key,
    required this.iconValue,
    required this.value,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onPressed,
      child: Card(
        elevation: 10,
        margin: EdgeInsets.all(7),
        child: Padding(

          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                iconValue,
                size: 25,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: Text(
                  value,
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
