import 'package:flutter/material.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/all_items_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/user_drink_menu.dart';
import 'package:kkhaney/Restaurantfromfilter/user_food_menu.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_food.dart';
import 'package:provider/provider.dart';

class AllFoodPage extends StatefulWidget {
  const AllFoodPage({Key? key}) : super(key: key);

  @override
  State<AllFoodPage> createState() => _AllFoodPageState();
}

class _AllFoodPageState extends State<AllFoodPage> {
  @override
  void initState() {

    super.initState();

    Provider.of<AllItemsProvider>(context,listen: false).getFood();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("Foods"),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<AllItemsProvider>(
            builder: (context,menuProvider,child) {
              if(menuProvider.isLoadingFood){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(menuProvider.serverFood.isEmpty){
                return Center(
                  child: Text("No Food"),
                );
              }
              return Column(
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Align(

                      alignment: Alignment.centerLeft,
                      child: ChoosableMultipleFilter(
                        filterList: menuProvider.foodCategory,
                        selectedIndex: menuProvider.foodFilterIndex,
                        onPressed: (int i) {
                          if(menuProvider.foodFilterIndex==i){

                            menuProvider.updateFilterFoodIndex(-1);

                          }else{
                            menuProvider.updateFilterFoodIndex(i);

                          }
                        },

                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(
                        builder: (context) {
                          List<ServerFoodModal> foodList=menuProvider.getFilteredServerFood();
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){

                              return MenuFoodUserWidget(serverFoodModal: foodList[index],key: ValueKey(foodList[index].id));
                            },
                            itemCount: foodList.length,
                          );
                        }
                    ),
                  ),
                ],
              );
            }
        )
    );
  }
}