import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:kkhaney/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/OrderAndCard/managert/cart_provider.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';

class OrderItemProvider with ChangeNotifier{
  final int orderId;
  OrderItemProvider({
    required this.orderId,
  }){
    getOrderItems();
  }

  bool isLoading=true;
  List<CartOrOrderItemModal> orderItemsList=[];
  Future<void> getOrderItems() async{
    Uri uri=Uri.parse(Constant.serverUrl+"orderItem/$orderId/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    orderItemsList.clear();
    for(Map map in responseData){
      orderItemsList.add(CartOrOrderItemModal.fromMap(map, map["food"]!=null,forCart: false));
    }
    isLoading=false;
    notifyListeners();


  }

}