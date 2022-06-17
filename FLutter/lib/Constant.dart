import 'package:flutter/material.dart';

class Constant {
  static Color primaryColor=Color(0xff52B788);
  static Color secondaryColor=Color(0xff74C69D);
  static Color kBackground=Color(0xFFFDBF30);
  static String serverUrl="http://192.168.254.32:8000/";
  static String tokenKey="token";
  static String userIdKey="userId";
  static String restaurantToken="restaurantToken";
  static InputDecoration getDecoration(String textLable){
    return
    InputDecoration(
      label: Text(textLable),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
        borderRadius: BorderRadius.circular(10.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
  static InputDecoration getSearchDecoration(String hinttext){
    return
      InputDecoration(
        hintText: hinttext,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none
      );
  }
}