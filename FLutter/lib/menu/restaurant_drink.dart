import 'package:flutter/material.dart';
import 'package:kkhaney/menu/restaurant_menu_add_edit_drink.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_food.dart';
import 'package:provider/provider.dart';

class RestaurantDrink extends StatelessWidget {
  const RestaurantDrink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RestaurantAddEditDrink())).then((value) {
              Provider.of<RestaurantMenuManager>(context,listen: false).getDrink();
            });
          },
          child: Icon(
              Icons.add
          ),
        ),
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
              return  Column(
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

                              return MenuDrinkWidget(serverDrinkModal: drinkList[index],);
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

class MenuDrinkWidget extends StatelessWidget {
  final ServerDrinkModal serverDrinkModal;
  const MenuDrinkWidget({
    required this.serverDrinkModal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>RestaurantAddEditDrink(drinkModal: serverDrinkModal,))
        ).then((value) {
          Provider.of<RestaurantMenuManager>(context,listen: false).getDrink();
        });
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
            ],
          ),
        ),
      ),
    );
  }
}


