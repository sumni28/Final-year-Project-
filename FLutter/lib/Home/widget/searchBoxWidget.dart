import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';

class SearchBoxWidget extends StatelessWidget {
  const SearchBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.fromLTRB(7,7,7,0),
      width: MediaQuery.of(context).size.width,
      child:
      Card(
        margin: EdgeInsets.zero,
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                flex: 9,
                child: TextField(
                  enabled: false,
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
