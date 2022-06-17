import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Home/HomePage.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/RestaurantArea/profile_edit_page.dart';
import 'package:kkhaney/RestaurantArea/restaurant_portal.dart';
import 'package:kkhaney/registration/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    initializeEverything();

    super.initState();
  }

  void initializeEverything() async{
    final sharedPref=await SharedPreferences.getInstance();
    String token=sharedPref.getString(Constant.tokenKey)??"";
    Future.delayed(Duration(seconds: 3),(){
      if(token==""){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>LogInPage()));
      }else if(token==Constant.restaurantToken){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>RestaurantPortal()));

      }
      else{
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>HomePage()));

      }
    });


  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width:MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                //backgroundColor: Colors.0xff52B788
                height: 350,
                width: 550,
                child: Image.asset(
                    "Photo/logo.png"
                ),
              ),
              CircularProgressIndicator()
            ],
          )
      ),
    );
  }


}
