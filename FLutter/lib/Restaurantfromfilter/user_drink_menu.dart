import 'package:flutter/material.dart';
import 'package:kkhaney/FoodPostDetail/FoodPostDetail.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';
import 'package:kkhaney/Restaurantfromfilter/ItemDetailPage.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/item_manager.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_food.dart';
import 'package:provider/provider.dart';

class UserDrinkMenu extends StatelessWidget {
  const UserDrinkMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Menu Drinks"),
          automaticallyImplyLeading: false,
        ),
        body: Consumer<RestaurantMenuManager>(
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

                            return MenuDrinkUserWidget(serverDrinkModal: drinkList[index],key: ValueKey(drinkList[index].id));
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

class MenuDrinkUserWidget extends StatelessWidget {
  final ServerDrinkModal serverDrinkModal;
  const MenuDrinkUserWidget({
    required this.serverDrinkModal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>ItemManager(isFood: false, itemId: serverDrinkModal.id??0),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context)=>ItemDetailPage(
                 data: ItemDetail(
                   startingEnding: "${serverDrinkModal.openingTime} to ${serverDrinkModal.closingTime}",
                   restaurantName: serverDrinkModal.restName??"",
                     name: serverDrinkModal.drinkName,
                     image: serverDrinkModal.drinkImage,
                     description: serverDrinkModal.drinkDescription,
                     price: serverDrinkModal.price,
                     id: serverDrinkModal.id??0,
                   isFood: false,
                     category: serverDrinkModal.drinkCategory,
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
                      serverDrinkModal.drinkImage,
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
                          serverDrinkModal.drinkName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                              fontSize: 18
                          ),
                        ),
                        Text(
                          serverDrinkModal.drinkDescription,

                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Price "+serverDrinkModal.price.toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16
                          ),
                        ),
                        Text(
                          "Category: "+serverDrinkModal.drinkCategory,
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


