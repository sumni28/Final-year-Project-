import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkhaney/Home/Model/FilteredItemModel.dart';

class SingleFilteredItem extends StatelessWidget {
  FilteredItemModel value;
  bool isSelected;
  SingleFilteredItem({
    required this.value,
    this.isSelected=false
  } // yaso garda jasto format ma lekhda ni milxa tara agadai value ya isSelected kun ho dinu paryo
      );

  @override
  Widget build(BuildContext context) {
    return  Tooltip(

      message: value.name,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            // color: Colors.grey.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30)
        ),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 2,
                child: Image.asset(
              value.image,
                )
            ),
            Expanded(
              child: Text(
                  value.name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeableSingleFilterItem extends StatelessWidget{
  String name;
  bool isSelected;
  Function()? onPressed;
  ChangeableSingleFilterItem({
    required this.onPressed,
    required this.name,
    this.isSelected=false
  }
      );

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onPressed,
      child: Tooltip(

        message: name,
        child: Container(
          margin: EdgeInsets.only(right: 10,bottom: 10),
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: isSelected?Colors.red.withOpacity(0.2):Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(30),
            border: Border.all(color: isSelected?Colors.red:Colors.grey,width: 2),
          ),
          child: Column(
            children: [
              Text(
                name,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}