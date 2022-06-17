import 'package:flutter/material.dart';
import 'package:kkhaney/Home/widget/SingleFoodItem.dart';
import 'package:kkhaney/Model/FoodModel.dart';

class FoodItemsList extends StatelessWidget {
  const FoodItemsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<FoodModel> foodData=FoodDummyData.dummyFoodData;
    return ListView(
      children: [
        for(int i=0;i<foodData.length;i++)
          SingleFoodItem(foodModel: foodData[i],)
      ],
    );
  }
}

