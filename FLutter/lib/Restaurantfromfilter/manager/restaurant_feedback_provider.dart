import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_from_filter_provider.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantFeedbackProvider with ChangeNotifier{

  int restaurantId;
  RestaurantFeedbackProvider({
    required this.restaurantId
  }){
    addFeedback();//To load rating and is liked

  }

  bool liked=false;
  int userRating=1;
  bool loadingLikeRating=true;

  int totalLikes=0;
  double totalRating=0;
  bool totalRatingLikesLoading=true;
  Future<void> getTotalRatingAndLikes() async{
    totalRatingLikesLoading=true;
    notifyListeners();
    Uri uri=Uri.parse(Constant.serverUrl+"restaurantTotalRating/$restaurantId/");
    http.Response response=await http.get(uri);
    final ratingResponseData=json.decode(response.body);
    if(ratingResponseData["rating"]==0){//when server send 0, its integer but totalRating is double
      totalRating=0.0;
    }else{
      totalRating=ratingResponseData["rating"];

    }
    uri=Uri.parse(Constant.serverUrl+"restaurantTotalLike/$restaurantId/");
    response=await http.get(uri);
    final likeResponseData=json.decode(response.body);
    totalLikes=likeResponseData["count"];
    totalRatingLikesLoading=false;
    notifyListeners();
  }

  Future<void> addFeedback({
    bool? enteredLiked,
    int? enteredRating,
  }) async{
    loadingLikeRating=true;
    notifyListeners();
    final sharedPref=await SharedPreferences.getInstance();
    int userId=sharedPref.getInt(Constant.userIdKey)??0;
    final feedback=RestaurantFeedback(
        userId: userId,
        restaurantId: restaurantId,
      liked: enteredLiked,
      rating:enteredRating,
    );
    Uri uri=Uri.parse(Constant.serverUrl+"addRestaurantFeedback/");
    http.Response response=await http.post(
        uri,
        headers: {
          "Content-Type":"application/json"
        },
        body: json.encode(feedback.getMap())
    );
    final responseData=json.decode(response.body);
    if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
    liked=responseData["RestaurantLiked"];
    userRating=responseData["restaurantRating"];
    loadingLikeRating=false;
    getTotalRatingAndLikes();
    notifyListeners();
  }
}