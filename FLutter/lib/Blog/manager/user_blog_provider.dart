
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_blog_manager.dart';
import 'package:kkhaney/registration/manager/HttpException.dart';
import 'package:http/http.dart' as http;
class UserBlogProvider with ChangeNotifier {


  UserBlogProvider() {
    getBlog();
  }

  List<ServerBlogModal> blogList = [];

  bool isLoading = true;

  Future<void> getBlog() async {
    Uri uri = Uri.parse(Constant.serverUrl + "blog/");
    http.Response response = await http.get(uri);
    final responseData = json.decode(response.body);
    if (response.statusCode > 299) throw HttpException(
        errorMessage: responseData.toString());
    blogList.clear();
    for (Map map in responseData) {
      blogList.add(ServerBlogModal.fromMap(map));
    }
    isLoading = false;
    notifyListeners();
  }
}