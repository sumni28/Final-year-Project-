import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/registration/manager/HttpException.dart';

class RestaurantFeedback{
  int? rating;
  int userId,restaurantId;
  bool? liked;

  RestaurantFeedback({
    required this.userId,
    required this.restaurantId,
    this.rating,
    this.liked,
  });

  factory RestaurantFeedback.fromMap(Map<String,dynamic> map){
    return RestaurantFeedback(
        userId: map["userId"],
        restaurantId: map["restaurantId"],
        rating:map["restaurantRating"],
        liked:map["RestaurantLiked"],
    );
  }

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map={
      "restaurantId":restaurantId,
      "userId":userId
    };
    if(rating!=null)map["restaurantRating"]=rating;
    if(liked!=null)map["RestaurantLiked"]=liked;
    return map;

  }
}

class FromFilterRestaurantProvider with ChangeNotifier{
  final List<RestaurantModal> _restaurantList=[];

  List<RestaurantModal> get restaurantList{
    if (filterByFav || !showSponsored) return _restaurantList;
    return _restaurantList.where((element) => element.sponsored).toList();
  }
  bool isLoading=true;
  bool showSponsored=true;

  bool filterByFav=false;

  void setBestRestaurant(){
    showSponsored=true;
    if(filterByFav){
      getRestaurantsList();
    }
    filterByFav=false;
    notifyListeners();
  }
  void toggleShowSponsored(){
    showSponsored=!showSponsored;
    notifyListeners();
    if(filterByFav){
      filterByFav=!filterByFav;//Remove filter by fav
      getRestaurantsList();
    }
  }

  void toggleFilter(){
    filterByFav=!filterByFav;
    showSponsored=false;
    if(filterByFav){
      getFavRestList();
    }else{

      getRestaurantsList();
    }
    notifyListeners();
  }
  FromFilterRestaurantProvider(){

    getRestaurantsList();
  }
  Future<void> getRestaurantsList() async{
    isLoading=true;
    notifyListeners();
    print("I was here2");
    Uri uri=Uri.parse(Constant.serverUrl+"restaurant/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    _restaurantList.clear();
    for(Map<String,dynamic> map in responseData){
      _restaurantList.add(RestaurantModal.fromMap(map));
    }
    isLoading=false;
    notifyListeners();
  }

  Future<void> getFavRestList() async{
    isLoading=true;
    notifyListeners();
    print("I was here2");
    Uri uri=Uri.parse(Constant.serverUrl+"getFavoriteRestaurant/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    _restaurantList.clear();
    for(Map<String,dynamic> map in responseData){
      _restaurantList.add(RestaurantModal.fromMap(map));
    }
    isLoading=false;
    notifyListeners();
  }


}