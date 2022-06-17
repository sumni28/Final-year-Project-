import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kkhaney/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserComments{
  String comment,email,user;
  UserComments({
    required this.comment,
    required this.email,
    required this.user

  });
  factory UserComments.fromMap(Map<String,dynamic> map){
    return UserComments(
        comment: map["comment"],
        email: map["user_id"]["email"],
        user: map["user_id"]["username"]
    );
  }
}
class RestaurantCommentProvider with ChangeNotifier{
  List<UserComments> commentsList=[];
  final int restaurantId;
  bool isLoading=true;
  RestaurantCommentProvider({
    required this.restaurantId,
  }){
    getComment();
  }
  Future<void> getComment() async{
    Uri uri=Uri.parse(Constant.serverUrl+"comment/$restaurantId/");
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
     Uri uri=Uri.parse(Constant.serverUrl+"comment/");
     http.Response response=await http.post(
       uri,
       headers: {
         "Content-Type":"application/json"
       },
       body: json.encode({
         "user_id":userId,
         "restaurant_id":restaurantId,
         "comment":comment,
       })
     );
     final responseData=json.decode(response.body);
     if(response.statusCode>299) throw HttpException(errorMessage: responseData.toString());
     await getComment();
  }
}