import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http_parser/http_parser.dart';
import 'package:kkhaney/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServerFoodModal{
  late int? id;
  late String foodName,foodCategory,foodDiscountCode,foodImage,foodDescription;
  late String? restName,openingTime,closingTime;
  late int price, restaurantId;
  ServerFoodModal({
    required this.foodName,
    required this.foodCategory,
    required this.foodDiscountCode,
    required this.foodImage,
    required this.foodDescription,
    required this.price,
    required this.restaurantId,
    this.id,

  });

  ServerFoodModal.fromMap(Map map){
    foodName=map["foodName"];
    foodCategory=map["foodCategory"];
    foodDiscountCode=map["foodDiscountcode"];
    foodImage=ImageGetter.getImageLocation(map["foodImage"]);
    foodDescription=map["foodDescription"];
    price=map["price"];
    restaurantId=map["restaurant_id"]["id"];
    restName=map["restaurant_id"]["restaurantName"];
    id=map["id"];
    openingTime=map["restaurant_id"]["openingTime"];
    closingTime=map["restaurant_id"]["closingTime"];
  }
}

class ServerDrinkModal{
  late int? id;
  late String drinkName,drinkCategory,drinkDiscountCode,drinkImage,drinkDescription;
  late int price, restaurantId;
  late String? restName,openingTime,closingTime;
  ServerDrinkModal({
    required this.drinkName,
    required this.drinkCategory,
    required this.drinkDiscountCode,
    required this.drinkImage,
    required this.drinkDescription,
    required this.price,
    required this.restaurantId,
    this.id,

  });

  ServerDrinkModal.fromMap(Map map){
    drinkName=map["drinkName"];
    drinkCategory=map["drinkCategory"];
    drinkDiscountCode=map["drinkDiscountcode"];
    drinkImage=ImageGetter.getImageLocation(map["drinkImage"]);
    drinkDescription=map["drinkDescription"];
    price=map["price"];
    restaurantId=map["restaurant_id"]["id"];
    restName=map["restaurant_id"]["restaurantName"];
    openingTime=map["restaurant_id"]["openingTime"];
    closingTime=map["restaurant_id"]["closingTime"];
    id=map["id"];
  }
}


class RestaurantMenuManager with ChangeNotifier{
  int restaurantId;
  RestaurantMenuManager({this.restaurantId=0}){
    getFood();
    getDrink();
  }
  List<ServerFoodModal> serverFood=[];
  List<ServerDrinkModal> serverDrink=[];
  bool isLoadingFood=true;
  bool isLoadingDrink=true;
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

  static Future<double> getTotalRating(int id,bool isFood) async{
    Uri uri=Uri.parse(Constant.serverUrl+"${isFood?"totalFoodRating":"totalDrinkRating"}/$id/");
    double totalRating=0.0;
    http.Response response=await http.get(uri);
    final ratingResponseData=json.decode(response.body);
    if(ratingResponseData["rating"]==0){//when server send 0, its integer but totalRating is double
      totalRating=0.0;
    }else{
      totalRating=ratingResponseData["rating"];

    }
    return totalRating;
  }

  static Future<int> getTotalOrder(int id,bool isFood) async{
    Uri uri=Uri.parse(Constant.serverUrl+"${isFood?"getTotalFoodOrders":"getTotalDrinkOrders"}/$id/");
    http.Response response=await http.get(uri);
    final data=json.decode(response.body);
    return data["count"];
  }
  static Future<int> getTotalLike(int id,bool isFood) async{
    Uri uri=Uri.parse(Constant.serverUrl+"${isFood?"totalFoodLike":"totalDrinkLike"}/$id/");
    http.Response response=await http.get(uri);
    final likeResponseData=json.decode(response.body);
    return likeResponseData["count"];
  }
  Future<void> getDrink() async{
    final sharedPref=await SharedPreferences.getInstance();
    if(restaurantId==0) restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
    Uri uri = Uri.parse(Constant.serverUrl+"drink/$restaurantId/");
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

  static Future<void> deleteDrink(int drinkId) async{
    Uri uri = Uri.parse(Constant.serverUrl+"drinkdetail/$drinkId/");
    await http.delete(uri);
  }
  static Future<void> editDrink(ServerDrinkModal drinkModal,String? image) async{
    Uri uri = Uri.parse(Constant.serverUrl+"drinkdetail/${drinkModal.id}/");
    var request = http.MultipartRequest("PATCH", uri);
    if(image!=null){

      File file=File(image);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=image.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes("drinkImage",byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
      request.files.add(multipartFileSign);
    }

    request.fields["drinkName"] =drinkModal.drinkName;
    request.fields["drinkCategory"] =drinkModal.drinkCategory;
    request.fields["drinkDiscountcode"] =drinkModal.drinkDiscountCode;
    request.fields["drinkDescription"] =drinkModal.drinkDescription;
    request.fields["price"] =drinkModal.price.toString();
    request.fields["restaurant_id"] =drinkModal.restaurantId.toString();
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
  }
  static Future<void> addDrink(ServerDrinkModal drinkModal) async{
    Uri uri = Uri.parse(Constant.serverUrl+"drink/");
    var request = http.MultipartRequest("POST", uri);
    File file=File(drinkModal.drinkImage);
    List<int> byteData=List.from(await file.readAsBytes());
    String imageName=drinkModal.drinkImage.split("/").last;
    var multipartFileSign =  http.MultipartFile.fromBytes("drinkImage",byteData,filename: imageName,
        contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
    request.files.add(multipartFileSign);
    request.fields["drinkName"] =drinkModal.drinkName;
    request.fields["drinkCategory"] =drinkModal.drinkCategory;
    request.fields["drinkDiscountcode"] =drinkModal.drinkDiscountCode;
    request.fields["drinkDescription"] =drinkModal.drinkDescription;
    request.fields["price"] =drinkModal.price.toString();
    request.fields["restaurant_id"] =drinkModal.restaurantId.toString();
    request.fields["date"] =DateTime.now().toString().substring(0,10);
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
  }







  Future<void> getFood() async{
    final sharedPref=await SharedPreferences.getInstance();
    if(restaurantId==0)restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
    Uri uri = Uri.parse(Constant.serverUrl+"food/$restaurantId/");
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

  static Future<void> deleteFood(int foodId) async{
    Uri uri = Uri.parse(Constant.serverUrl+"fooddetail/$foodId/");
    await http.delete(uri);
  }
  static Future<void> editFood(ServerFoodModal foodModal,String? image) async{
    Uri uri = Uri.parse(Constant.serverUrl+"fooddetail/${foodModal.id}/");
    var request = http.MultipartRequest("PATCH", uri);
    if(image!=null){

      File file=File(image);
      List<int> byteData=List.from(await file.readAsBytes());
      String imageName=image.split("/").last;
      var multipartFileSign =  http.MultipartFile.fromBytes("foodImage",byteData,filename: imageName,
          contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
      request.files.add(multipartFileSign);
    }

    request.fields["foodName"] =foodModal.foodName;
    request.fields["foodCategory"] =foodModal.foodCategory;
    request.fields["foodDiscountcode"] =foodModal.foodDiscountCode;
    request.fields["foodDescription"] =foodModal.foodDescription;
    request.fields["price"] =foodModal.price.toString();
    request.fields["restaurant_id"] =foodModal.restaurantId.toString();
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
  }
  static Future<void> addFood(ServerFoodModal foodModal) async{
    Uri uri = Uri.parse(Constant.serverUrl+"food/");
    var request = http.MultipartRequest("POST", uri);
    File file=File(foodModal.foodImage);
    List<int> byteData=List.from(await file.readAsBytes());
    String imageName=foodModal.foodImage.split("/").last;
    var multipartFileSign =  http.MultipartFile.fromBytes("foodImage",byteData,filename: imageName,
        contentType: MediaType('multipart', 'form-data',{"charset": "utf-8"}));
    request.files.add(multipartFileSign);
    request.fields["foodName"] =foodModal.foodName;
    request.fields["foodCategory"] =foodModal.foodCategory;
    request.fields["foodDiscountcode"] =foodModal.foodDiscountCode;
    request.fields["foodDescription"] =foodModal.foodDescription;
    request.fields["price"] =foodModal.price.toString();
    request.fields["restaurant_id"] =foodModal.restaurantId.toString();

    request.fields["date"] =DateTime.now().toString().substring(0,10);
    final streamResponse=await request.send();
    final response= await http.Response.fromStream(streamResponse);
    final responseData = json.decode(utf8.decode(response.bodyBytes));
    if (response.statusCode >= 300) throw HttpException(errorMessage: responseData.toString());
  }
}