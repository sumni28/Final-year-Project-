
import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';

class Menu extends StatelessWidget {
  const Menu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      child:
      Card(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: TextField(
                  decoration: Constant.getSearchDecoration("search"),

                ),
              ),
              Expanded(
                flex: 1,
                child: Icon(
                  Icons.search,
                  color: Constant.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
