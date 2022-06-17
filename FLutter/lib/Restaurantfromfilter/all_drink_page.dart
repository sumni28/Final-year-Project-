import 'package:flutter/material.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/all_items_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/user_drink_menu.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_food.dart';
import 'package:provider/provider.dart';

class AllDrinkPage extends StatefulWidget {
  const AllDrinkPage({Key? key}) : super(key: key);

  @override
  State<AllDrinkPage> createState() => _AllDrinkPageState();
}

class _AllDrinkPageState extends State<AllDrinkPage> {
  @override
  void initState() {

    super.initState();
    Provider.of<AllItemsProvider>(context,listen: false).getDrink();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Drinks"),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<AllItemsProvider>(
            builder: (context,menuProvider,child) {
              if(menuProvider.isLoadingDrink){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(menuProvider.serverDrink.isEmpty){
                return Center(
                  child: Text("No Drink"),
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
                        filterList: menuProvider.drinkCategory,
                        selectedIndex: menuProvider.drinkFilterIndex,
                        onPressed: (int i) {
                          if(menuProvider.drinkFilterIndex==i){

                            menuProvider.updateFilterDrinkIndex(-1);

                          }else{
                            menuProvider.updateFilterDrinkIndex(i);

                          }
                        },

                      ),
                    ),
                  ),
                  Expanded(
                    child: Builder(
                        builder: (context) {
                          List<ServerDrinkModal> drinkList=menuProvider.getFilteredServerDrink();
                          return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index){

                              return MenuDrinkUserWidget(serverDrinkModal: drinkList[index],key: ValueKey(drinkList[index].id),);
                            },
                            itemCount: drinkList.length,
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