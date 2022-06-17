import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:kkhaney/Constant.dart';
import 'package:http/http.dart' as http;
import 'package:kkhaney/RestaurantArea/manager/restaurant_blog_manager.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
enum NotificationType{
  Food,
  Drink,
  Blog
}
class NotificationModal{
  String heading;
  String subheading;
  int id;
  String image;
  NotificationType type;
  ServerBlogModal? blogModal;
  ServerDrinkModal? drinkModal;
  ServerFoodModal? foodModal;
  NotificationModal(
  {
    this.blogModal,
    required this.heading,
    this.drinkModal,
    this.foodModal,
    required this.subheading,
    required this.id,
    required this.image,
    required this.type
  });
}
class NotificationProvider with ChangeNotifier{
  List<NotificationModal> notificationList=[];
  bool isLoading=true;
  NotificationProvider(){
    getNotification();
  }
  Future<void> getNotification() async{
    notificationList.clear();
    Uri uri1=Uri.parse(Constant.serverUrl+"todayBlog/");
    http.Response response=await http.get(uri1);
    final responseData=json.decode(response.body);
    for(Map map in responseData){
      notificationList.add(
        NotificationModal(
            heading: "New Blog!!",
            subheading: "${map["restaurant"]["restaurantName"]} have added a new blog, \"${map["heading"]}\". Check It Out",
            id: map["id"],
            image: ImageGetter.getImageLocation(map["image"]),
            type: NotificationType.Blog,
          blogModal: ServerBlogModal.fromMap(map)
        )
      );
    }
    Uri uri2=Uri.parse(Constant.serverUrl+"todayDrink/");
    http.Response response2=await http.get(uri2);
    final responseData2=json.decode(response2.body);
    for(Map map in responseData2){
      notificationList.add(
          NotificationModal(
              heading: "New Drink!!",
              subheading: "${map["restaurant_id"]["restaurantName"]} have added a new Drink, \"${map["drinkName"]}\". Order It Now!!",
              id: map["id"],
              image: ImageGetter.getImageLocation(map["drinkImage"]),
              type: NotificationType.Drink,
            drinkModal:ServerDrinkModal.fromMap(map)
          )
      );
    }
    Uri uri3=Uri.parse(Constant.serverUrl+"todayFood/");
    http.Response response3=await http.get(uri3);
    final responseData3=json.decode(response3.body);
    for(Map map in responseData3){
      notificationList.add(
          NotificationModal(
              heading: "New Food!!",
              subheading: "${map["restaurant_id"]["restaurantName"]} have added a new Food, \"${map["foodName"]}\". Order It Now!!",
              id: map["id"],
              image: ImageGetter.getImageLocation(map["foodImage"]),
              type: NotificationType.Food,
              foodModal:ServerFoodModal.fromMap(map)
          )
      );
    }

    notificationList.shuffle();
    isLoading=false;
    notifyListeners();
  }
}