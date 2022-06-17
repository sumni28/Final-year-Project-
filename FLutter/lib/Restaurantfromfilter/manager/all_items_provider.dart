import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
class AllItemsProvider with ChangeNotifier{

  AllItemsProvider(){
    getDrink();
    getFood();
  }
  List<ServerDrinkModal> serverDrink=[];
  List<ServerFoodModal> serverFood=[];
  bool isLoadingDrink=true;
  bool isLoadingFood=true;
  int drinkFilterIndex=-1;//Nothing
  int foodFilterIndex=-1;//Nothing
  List<String> drinkCategory=[];
  List<String> foodCategory=[];
  List<ServerDrinkModal> getFilteredServerDrink(){
    if(drinkFilterIndex==-1) return serverDrink;
    return serverDrink.where((element) => element.drinkCategory==drinkCategory[drinkFilterIndex]).toList();
  }
  List<ServerFoodModal> getFilteredServerFood(){
    if(foodFilterIndex==-1) return serverFood;
    return serverFood.where((element) => element.foodCategory==foodCategory[foodFilterIndex]).toList();
  }
  void updateFilterDrinkIndex(int i){
    drinkFilterIndex=i;
    notifyListeners();
  }
  void updateFilterFoodIndex(int i){
    foodFilterIndex=i;
    notifyListeners();
  }

  Future<void> getDrink() async{
    Uri uri = Uri.parse(Constant.serverUrl+"drink/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    serverDrink.clear();
    drinkCategory.clear();
    for(Map map in responseData){
      ServerDrinkModal serverDrinkModal=ServerDrinkModal.fromMap(map);
      serverDrink.add(serverDrinkModal);
      drinkCategory.removeWhere((element) => element==serverDrinkModal.drinkCategory);
      drinkCategory.add(serverDrinkModal.drinkCategory);
    }
    isLoadingDrink=false;
    notifyListeners();
  }

  Future<void> getFood() async{
    Uri uri = Uri.parse(Constant.serverUrl+"food/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    serverFood.clear();
    foodCategory.clear();
    for(Map map in responseData){
      ServerFoodModal serverFoodModal=ServerFoodModal.fromMap(map);
      serverFood.add(serverFoodModal);
      foodCategory.removeWhere((element) => element==serverFoodModal.foodCategory);
      foodCategory.add(serverFoodModal.foodCategory);
    }
    isLoadingFood=false;
    notifyListeners();
  }
}