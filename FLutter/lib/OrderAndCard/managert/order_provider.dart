import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/OrderAndCard/managert/cart_provider.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Order{
  int id;
  int totalPrice;
  bool restaurantDelivered;
  bool userReceived;
  String userPhone;
  RestaurantModal restaurantModal;
  String location;
  bool paymentDone;
  bool paymentByCash;
  bool forDonating;
  String? preOrderDate;
  Order({
    required this.location,
    required this.paymentDone,
    required this.paymentByCash,
    required this.forDonating,
    required this.preOrderDate,
    required this.id,
    required this.totalPrice,
    required this.restaurantModal,
    required this.userPhone,
    required this.restaurantDelivered,
    required this.userReceived
  });

  factory Order.fromMap(Map map){
    return Order(
        location: map["location"],
        paymentDone: map["paymentDone"],
        paymentByCash: map["paymentByCash"],
        forDonating: map["forDonating"],
        preOrderDate: map["preOrderDate"],
        id: map["id"],
        totalPrice: map["totalPrice"],
        restaurantModal: RestaurantModal.fromMap(map["restaurant"]),
        userPhone: map["user"]["username"],
        restaurantDelivered: map["restaurantDelivered"],
        userReceived: map["userReceived"]
    );
  }
}
class OrderProvider with ChangeNotifier{

  final bool forUser;
  OrderProvider({
    required this.forUser
  }){
    getOrder();
  }

  static Future<void> proceedOrder({
    required List<CartOrOrderItemModal> cartList,
    required int totalPrice,
    required String location,
    bool paymentByCash=false,
    bool forDonating=false,
    String? preOrderDate,
  }) async{
    List<int> restaurantIdList=[];
    for(CartOrOrderItemModal cart in cartList){
      int restaurantId=cart.itemDetail.restaurantId??0;
      restaurantIdList.removeWhere((element) => restaurantId==element);//TO add unique restaurant Id
      restaurantIdList.add(restaurantId);
    }
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    Uri orderUri =Uri.parse(Constant.serverUrl+"order/");
    Uri orderItemUri =Uri.parse(Constant.serverUrl+"orderItem/");
    for (int restId in restaurantIdList){
      http.Response response=await http.post(
        orderUri,
        headers: {
          "Content-Type":"Application/json"
        },
        body: json.encode({
          "user":userId,
          "restaurant":restId,
          "totalPrice":totalPrice,
          "location":location,
          "paymentDone":!paymentByCash,//If payment by khalti, payment already done
          "paymentByCash":paymentByCash,
          "forDonating":forDonating,
          "preOrderDate":preOrderDate,
          "userReceived":forDonating,//If for donating, user will never receive, so by default user received true

        })
      );
      final orderResponse=json.decode(response.body);
      if(response.statusCode>299) throw HttpException(errorMessage: orderResponse.toString());
      int order=orderResponse["id"];
      List<CartOrOrderItemModal> specificRestaurantCart=cartList.where((element) => element.itemDetail.restaurantId==restId).toList();
      List<String> jsonBody=[];
      for (CartOrOrderItemModal item in specificRestaurantCart){
        Map map={
          "order":order,
          "quantity":item.quantity,
          "notes":item.notes
        };
        map[item.itemDetail.isFood?"food":"drink"]=item.itemDetail.id;
        jsonBody.add(json.encode(map));
      }
      print(specificRestaurantCart.length);
      print(jsonBody);
      http.Response response2=await http.post(
        orderItemUri,
        headers: {
          "Content-Type":"Application/json"
        },
        body: jsonBody.toString()
      );
      final responseData=json.decode(response2.body);
      if(response2.statusCode>299) throw HttpException(errorMessage: responseData.toString());

    }
    for(CartOrOrderItemModal cart in cartList){
      Uri uri =Uri.parse(Constant.serverUrl+"cart/${cart.id}/");
      await http.delete(uri);
    }
  }



  final List<Order> orderList=[];
  bool isLoading=true;
  Future<void> getOrder({bool showLoading=false}) async{
    if(showLoading){
      isLoading=true;
      notifyListeners();
    }
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    int restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
    Uri uri=Uri.parse(Constant.serverUrl+"${forUser?"userOrder":"restaurantOrder"}/${forUser?userId:restaurantId}/");
    http.Response response = await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    orderList.clear();
    for(Map map in responseData){
      orderList.add(Order.fromMap(map));
    }
    isLoading=false;
    notifyListeners();
  }

  static Future<void> userReceived(int orderId) async{
    Uri uri =Uri.parse(Constant.serverUrl+"order/$orderId/");
    http.Response response=await http.patch(
        uri,
        headers: {
          "Content-Type":"Application/json"
        },
        body: json.encode({
          "userReceived":true,
        })
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
  }

  static Future<void> restaurantDelivered(int orderId) async{
    Uri uri =Uri.parse(Constant.serverUrl+"order/$orderId/");
    http.Response response=await http.patch(
        uri,
        headers: {
          "Content-Type":"Application/json"
        },
        body: json.encode({
          "restaurantDelivered":true,
        })
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
  }
}