import 'package:flutter/material.dart';
import 'package:kkhaney/Home/Model/FilteredItemModel.dart';
import 'package:kkhaney/Home/widget/SingleFilteredItem.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_add_edit_food.dart';
import 'package:provider/provider.dart';

class RestaurantFood extends StatelessWidget {
  const RestaurantFood({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RestaurantAddEditFood())).then((value) {
                    Provider.of<RestaurantMenuManager>(context,listen: false).getFood();
          });
        },
        child: Icon(
          Icons.add
        ),
      ),
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
                          return MenuFoodWidget(serverFoodModal: foodList[index],);
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

class ChoosableMultipleFilter extends StatelessWidget {
  final Function(int i) onPressed;
  final int selectedIndex;
  final List<String> filterList;
  const ChoosableMultipleFilter({
    required this.onPressed,
    required this.filterList,
    required this.selectedIndex,
    Key? key,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for(int i=0;i<filterList.length;i++)
            InkWell(
              onTap: (){
                onPressed(i);
              },
              child: ChangeableSingleFilterItem(
                name: filterList[i],
                onPressed: null,
                isSelected: selectedIndex==i,
              ),
            ),
        ],
      ),
    );
  }
}




class MenuFoodWidget extends StatelessWidget {
  final ServerFoodModal serverFoodModal;
  const MenuFoodWidget({
    required this.serverFoodModal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>RestaurantAddEditFood(foodModal: serverFoodModal,))
        ).then((value) {
          Provider.of<RestaurantMenuManager>(context,listen: false).getFood();
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
            ],
          ),
        ),
      ),
    );
  }
}


