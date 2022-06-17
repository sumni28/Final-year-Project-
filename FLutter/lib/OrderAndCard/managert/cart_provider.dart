import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/Restaurantfromfilter/ItemDetailPage.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class CartOrOrderItemModal{
  int? id;
  ItemDetail itemDetail;
  int quantity;
  String? notes;
  int userId;
  CartOrOrderItemModal({
    required this.id,
    required this.itemDetail,
    required this.quantity,
    required this.notes,
    required this.userId,
  });

  factory CartOrOrderItemModal.fromMap(Map map,bool isFood,{bool forCart=true}){
    Map specificItemMap=map[isFood?forCart?"foodId":"food":forCart?"drinkId":"drink"];
    Map restaurantMap=specificItemMap["restaurant_id"];
    return CartOrOrderItemModal(
      id: map["id"],
        itemDetail: ItemDetail(
            startingEnding: restaurantMap["openingTime"]+" to "+restaurantMap["closingTime"],
            image: ImageGetter.getImageLocation(specificItemMap[isFood?"foodImage":"drinkImage"]),
            id: specificItemMap["id"],
            name: specificItemMap[isFood?"foodName":"drinkName"],
            price: specificItemMap["price"],
            discountCode:specificItemMap[isFood?"foodDiscountcode":"drinkDiscountcode"] ,
            description: specificItemMap[isFood?"foodDescription":"drinkDescription"],
            category: specificItemMap[isFood?"foodCategory":"drinkCategory"],
            isFood: isFood,
            restaurantName: restaurantMap["restaurantName"],
            restaurantId:restaurantMap["id"]

        ),
        userId: map["userId"]??0,
        quantity: map["quantity"],
        notes: map["notes"]
    );
  }



  Map getMap(){
    Map map= {
      "notes":notes,
      "quantity":quantity,
      "userId":userId,
    };
    map[itemDetail.isFood?"foodId":"drinkId"]=itemDetail.id;
    return map;
  }
}
class CartProvider with ChangeNotifier{
  CartProvider(){
    getUserCart();
  }
  final List<CartOrOrderItemModal> cartList=[];
  bool isLoading=true;

  int get totalPrice{
    int total=0;
    for(CartOrOrderItemModal cart in cartList){
      total+=cart.itemDetail.price*cart.quantity;
    }
    return total;
  }
  Future<void> getUserCart({bool showReload=false}) async{
    if(showReload){
      isLoading=true;
      notifyListeners();
    }
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    Uri uri =Uri.parse(Constant.serverUrl+"usercart/$userId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage:responseData.toString());
    cartList.clear();
    for (Map map in responseData){
      if(map["foodId"]!=null){
        cartList.add(CartOrOrderItemModal.fromMap(map, true));
      }else if(map["drinkId"]!=null){
        cartList.add(CartOrOrderItemModal.fromMap(map, false));
      }
    }
    isLoading=false;
    notifyListeners();
  }

  Future<void> deleteCart(int id) async{
    Uri uri =Uri.parse(Constant.serverUrl+"cart/$id/");
    http.Response response =await http.delete(uri);
    if(response.statusCode>299) throw HttpException(errorMessage:"Error Deleting");
    await getUserCart();
  }

  Future<void> updateQuantity(int id,int quantity)async{
    if(quantity<1 || quantity>10) return;
    Uri uri =Uri.parse(Constant.serverUrl+"cart/$id/");
    http.Response response =await http.patch(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
      body: json.encode({
        "quantity":quantity
      })
    );
    if(response.statusCode>299) throw HttpException(errorMessage:"Error");
    await getUserCart();
  }

  static Future<void> addCart(CartOrOrderItemModal cart) async{
    Uri uri =Uri.parse(Constant.serverUrl+"cart/");
    http.Response response =await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body:json.encode(cart.getMap()),
    );
    if(response.statusCode>299) throw HttpException(errorMessage:"Error");


  }
}