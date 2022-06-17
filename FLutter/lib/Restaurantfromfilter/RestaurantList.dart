import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kkhaney/Home/Model/FilteredItemModel.dart';
import 'package:kkhaney/Home/widget/SingleFilteredItem.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantWidget.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_from_filter_provider.dart';
import 'package:provider/provider.dart';


class RestaurantContainer extends StatefulWidget {

  RestaurantContainer({
    Key? key,
  }) : super(key: key);

  @override
  State<RestaurantContainer> createState() => _RestaurantContainerState();
}

class _RestaurantContainerState extends State<RestaurantContainer> {
  @override
  void initState() {
    super.initState();
    print("I was here1");
    Provider.of<FromFilterRestaurantProvider>(context,listen: false).setBestRestaurant();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Restaurants"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 10,),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Consumer<FromFilterRestaurantProvider>(
                      builder: (context,provider,child){
                        return Wrap(
                          children: [
                            ChangeableSingleFilterItem(

                              isSelected: provider.showSponsored,
                              name: 'Best Restaurants',
                              onPressed: () {
                                provider.toggleShowSponsored();
                              },
                            ),
                            ChangeableSingleFilterItem(

                              isSelected: provider.filterByFav,
                              name: 'Favorite',
                              onPressed: () {
                                provider.toggleFilter();
                              },
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ),
              Expanded(
                child: Consumer<FromFilterRestaurantProvider>(
                  builder: (context,provider,child) {
                    if(provider.isLoading){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    else if(provider.restaurantList.isEmpty){
                      return Center(
                        child: Text("No Restaurant"),
                      );
                    }
                    return ListView.builder(
                        itemBuilder: (context,index){
                          return RestaurantWidget(

                              data: provider.restaurantList[index],
                            key: ValueKey(provider.restaurantList[index].id),
                          );
                        },
                      itemCount: provider.restaurantList.length,
                    );
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

