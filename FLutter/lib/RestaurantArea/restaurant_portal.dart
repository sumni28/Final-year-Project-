import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/About/DrawerItem.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/Widget/Menu.dart';
import 'package:kkhaney/OrderAndCard/order_page.dart';
import 'package:kkhaney/RestaurantArea/profile_edit_page.dart';
import 'package:kkhaney/RestaurantArea/restauratant_blog.dart';
import 'package:kkhaney/menu/restaurant_side_menu.dart';
import 'package:kkhaney/splashPage/splashPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RestaurantPortal extends StatelessWidget {
  const RestaurantPortal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Text(
                    "Restaurant Area",
                  style: TextStyle(
                    fontSize: 25,
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20,),
                SizedBox(
                  //backgroundColor: Colors.0xff52B788
                  height: 150,
                  width: double.infinity,
                  child: Image.asset(
                      "Photo/logo.png"
                  ),
                ),
                SizedBox(height: 20,),
                CustomCard(
                  iconValue: Icons.home_outlined,
                  value: 'Edit Restaurant',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantProfileEdit()));
                  },
                ),
                SizedBox(height: 10,),
                CustomCard(
                  iconValue: FontAwesomeIcons.edit,
                  value: 'Customize Menu',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantMenu()));
                  },
                ),
                SizedBox(height: 10,),
                CustomCard(
                  iconValue: Icons.notification_important,
                  value: 'Orders Notification',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OrderPage(forUser: false)));
                  },
                ),
                SizedBox(height: 10,),
                CustomCard(
                  iconValue: FontAwesomeIcons.blog,
                  value: 'Blogs',
                  onPressed: () async{
                    final sharedPref=await SharedPreferences.getInstance();
                    int restaurantId=sharedPref.getInt(Constant.restaurantToken)??0;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantBlog(restaurantId: restaurantId))
                    );
                  },
                ),
                SizedBox(height: 10,),
                CustomCard(
                  iconValue: Icons.logout,
                  value: 'Logout',
                  onPressed: () async{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              "Log Out", //,
                              //style:Styles.mediumHeading
                            ),
                            content:
                            Text("Do you really want to Log Out"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, true); //true is value
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(
                                        context, false); //true is value
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w600),
                                  )),
                            ],
                          );
                        })
                        .then((value) async{
                      if (value==true){
                        final sharedPref=await SharedPreferences.getInstance();
                        sharedPref.setString(Constant.tokenKey, "");
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Logged Out")));
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SplashPage()));
                      }
                    });


                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
