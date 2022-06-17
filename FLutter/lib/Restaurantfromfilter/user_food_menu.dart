import 'package:flutter/material.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Restaurantfromfilter/ItemDetailPage.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/item_manager.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_add_edit_food.dart';
import 'package:kkhaney/menu/restaurant_food.dart';
import 'package:provider/provider.dart';

class UserFoodMenu extends StatelessWidget {
  const UserFoodMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menu Foods"),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<RestaurantMenuManager>(
            builder: (context,menuProvider,child) {
              if(menuProvider.isLoadingFood){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(menuProvider.serverFood
                  .isEmpty){
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

class MenuFoodUserWidget extends StatelessWidget {
  final ServerFoodModal serverFoodModal;
  const MenuFoodUserWidget({
    required this.serverFoodModal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ItemManager(isFood: true, itemId: serverFoodModal.id??0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>ItemDetailPage(
                data: ItemDetail(
                    startingEnding: "${serverFoodModal.openingTime} to ${serverFoodModal.closingTime}",
                    restaurantName: serverFoodModal.restName??"",
                    name: serverFoodModal.foodName,
                    image: serverFoodModal.foodImage,
                    description: serverFoodModal.foodDescription,
                    price: serverFoodModal.price,
                    id: serverFoodModal.id??0,
                    isFood: true,
                    category: serverFoodModal.foodCategory,
                    discountCode: ''
                ),
              )
              )
          );
        },
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          child: Padding(
            padding: EdgeInsets.all(10),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 2,
                    child: Image.network(
                      serverFoodModal.foodImage,
                      fit: BoxFit.cover,
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          serverFoodModal.foodName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 18
                          ),
                        ),
                        Text(
                          serverFoodModal.foodDescription,

                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Price "+serverFoodModal.price.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ),
                        Text(
                          "Category: "+serverFoodModal.foodCategory,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),
                        )
                      ],
                    )
                ),
                SizedBox(width: 10,),
                Expanded(
                    child: ItemLikeIcon(
                      key: ValueKey(serverFoodModal.id),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


