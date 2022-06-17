import 'package:flutter/material.dart';
import 'package:kkhaney/Home/Model/FilteredItemModel.dart';
import 'package:kkhaney/Home/widget/SingleFilteredItem.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantList.dart';
import 'package:kkhaney/Restaurantfromfilter/all_drink_page.dart';
import 'package:kkhaney/Restaurantfromfilter/all_food_page.dart';

class FilteredListView extends StatefulWidget {

  FilteredListView({
    Key? key,
  }) : super(key: key);

  @override
  State<FilteredListView> createState() => _FilteredListViewState();
}

class _FilteredListViewState extends State<FilteredListView> {
  int selectedIndex=-1; // when you open the Home page the no foosItemList is selected
  String _password="abcd";
  final List<FilteredItemModel> filteredItemName=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItemName.add(
      FilteredItemModel(
        name: "Restaurant",
        image: "FilteredListViewPhotos/Restaurant Logo.png",
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>RestaurantContainer()));//Open another
        },
      ),
    );
    filteredItemName.add(
      FilteredItemModel(
          name: "Foods",
          image: "FilteredListViewPhotos/BakeryLogo.png",
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AllFoodPage()));//Open another
          },
      ),
    );
    filteredItemName.add(
      FilteredItemModel(
          name: "Drinks",
          image: "FilteredListViewPhotos/Refreshment Logo.png",
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AllDrinkPage()));//Open another
          },
      ),
    );
    filteredItemName.add(
        FilteredItemModel(
            name: "Liquors",
            image: "FilteredListViewPhotos/Liquors Logo.png",
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>RestaurantContainer()));//Open another
            },
        ),
    );

  }

  @override
  Widget build(BuildContext context) {
    this._password="abd";
    _password="abd";
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 90,
      width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            for(int index=0;index<filteredItemName.length;index++)
              Expanded(
                child: GestureDetector(
                  onTap: filteredItemName[index].onPressed,
                  child: SingleFilteredItem(
                    isSelected:selectedIndex==index,
                      value:filteredItemName[index],

                  ),
                ),
              ),
          ],
        ),
    );
  }
}



