import 'package:flutter/cupertino.dart';
import 'dart:convert';

import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_comment_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_from_filter_provider.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FoodFeedback{
  int? rating;
  int userId,foodId;
  bool? liked;

  FoodFeedback({
    required this.userId,
    required this.foodId,
    this.rating,
    this.liked,
  });

  factory FoodFeedback.fromMap(Map<String,dynamic> map){
    return FoodFeedback(
      userId: map["userId"],
      foodId: map["food_id"],
      rating:map["rating"],
      liked:map["liked"],
    );
  }

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map={
      "food_id":foodId,
      "userId":userId
    };
    if(rating!=null)map["rating"]=rating;
    if(liked!=null)map["liked"]=liked;
    return map;

  }
}

class DrinkFeedback{
  int? rating;
  int userId,drinkId;
  bool? liked;

  DrinkFeedback({
    required this.userId,
    required this.drinkId,
    this.rating,
    this.liked,
  });

  factory DrinkFeedback.fromMap(Map<String,dynamic> map){
    return DrinkFeedback(
      userId: map["userId"],
      drinkId: map["drink_id"],
      rating:map["rating"],
      liked:map["liked"],
    );
  }

  Map<String,dynamic> getMap(){
    Map<String,dynamic> map={
      "drink_id":drinkId,
      "userId":userId
    };
    if(rating!=null)map["rating"]=rating;
    if(liked!=null)map["liked"]=liked;
    return map;

  }
}


class ItemManager with ChangeNotifier{
  int itemId;
  bool isFood;

  ItemManager({
    required this.isFood,
    required this.itemId,

  }){
    if(isFood){
      addFoodFeedback();//To get initial rating and like
    }else{
      addDrinkFeedback();

    }
  }


  bool liked=false;
  int rating=1;
  bool loadingLikeRating=true;



  Future<void> addFeedback({
    bool? enteredLiked,
    int? enteredRating,
  }) async{
    if(isFood){
      await addFoodFeedback(
        enteredRating: enteredRating,
        enteredLiked: enteredLiked
      );
    }else{
      await addDrinkFeedback(
          enteredRating: enteredRating,
          enteredLiked: enteredLiked
      );
    }
  }

  Future<void> addFoodFeedback({
    bool? enteredLiked,
    int? enteredRating,
  }) async{
    loadingLikeRating=true;
    notifyListeners();
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    final feedback=FoodFeedback(
      userId: userId,
      foodId: itemId,
      liked: enteredLiked,
      rating:enteredRating,
    );
    Uri uri=Uri.parse(Constant.serverUrl+"addFoodFeedback/");
    http.Response response=await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body: json.encode(feedback.getMap())
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    liked=responseData["liked"];
    rating=responseData["rating"];
    loadingLikeRating=false;
    getTotalRatingAndLikes();
    notifyListeners();
  }

  int totalLikes=0;
  double totalRating=0;
  bool totalRatingLikesLoading=true;
  Future<void> getTotalRatingAndLikes() async{
    totalRatingLikesLoading=true;
    notifyListeners();
    Uri uri=Uri.parse(Constant.serverUrl+"${isFood?"totalFoodRating":"totalDrinkRating"}/$itemId/");
    http.Response response=await http.get(uri);
    final ratingResponseData=json.decode(response.body);
    if(ratingResponseData["rating"]==0){//when server send 0, its integer but totalRating is double
      totalRating=0.0;
    }else{
      totalRating=ratingResponseData["rating"];

    }
    uri=Uri.parse(Constant.serverUrl+"${isFood?"totalFoodLike":"totalDrinkLike"}/$itemId/");
    response=await http.get(uri);
    final likeResponseData=json.decode(response.body);
    totalLikes=likeResponseData["count"];
    totalRatingLikesLoading=false;
    notifyListeners();
  }

  Future<void> addDrinkFeedback({
    bool? enteredLiked,
    int? enteredRating,
  }) async{
    loadingLikeRating=true;
    notifyListeners();
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    final feedback=DrinkFeedback(
      userId: userId,
      drinkId: itemId,
      liked: enteredLiked,
      rating:enteredRating,
    );
    Uri uri=Uri.parse(Constant.serverUrl+"addDrinkFeedback/");
    http.Response response=await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body: json.encode(feedback.getMap())
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    liked=responseData["liked"];
    rating=responseData["rating"];
    loadingLikeRating=false;
    getTotalRatingAndLikes();
    notifyListeners();
  }
}


class ItemCommentProvider with ChangeNotifier{
  List<UserComments> commentsList=[];
  final int id;
  final bool isFood;
  bool isLoading=true;
  ItemCommentProvider({
    required this.isFood,
    required this.id,
  }){
    getComment();
  }
  Future<void> getComment() async{
    Uri uri=Uri.parse(Constant.serverUrl+"${isFood?"foodComment":"drinkComment"}/$id/");
    http.Response response=await http.get(uri);
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    commentsList.clear();
    for (Map<String,dynamic> map in responseData){
      commentsList.add(UserComments.fromMap(map));
    }

    isLoading=false;
    notifyListeners();
  }

  Future<void> addComment(String comment) async{
    isLoading=true;
    notifyListeners();
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    Uri uri=Uri.parse(Constant.serverUrl+"${isFood?"foodComment":"drinkComment"}/");
    http.Response response=await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body: json.encode({
          "user_id":userId,
          isFood?"food_id":"drink_id":id,
          "comment":comment,
        })
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    await getComment();
  }
}

