
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/About/ContactPage.dart';
import 'package:kkhaney/AccountNotification/AccountPage.dart';
import 'package:kkhaney/AccountNotification/EditProfile.dart';
import 'package:kkhaney/Blog/BlogPage.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/FoodViewPage.dart';
import 'package:kkhaney/OrderAndCard/order_page.dart';
import 'package:kkhaney/OrderAndCard/user_cart.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantList.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _currentPage = 0;
  List<Widget> screens = [
    FoodViewPage(),
    UserCart(),
    OrderPage(forUser: true),
    BlogPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: SafeArea(
        child: Scaffold(

          body: screens[_currentPage],
          bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: _currentPage,
            backgroundColor: Colors.white,

            type: BottomNavigationBarType.fixed,
            selectedItemColor: Constant.primaryColor,
            unselectedItemColor: Colors.grey.withOpacity(0.6),
            selectedFontSize: 11,
            unselectedFontSize: 11,

            onTap: (selectedPage) {

              setState(() {
                _currentPage=selectedPage;
              });


            },
            selectedIconTheme: IconThemeData(color: Constant.primaryColor),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",

              ),
              BottomNavigationBarItem(
                icon: Icon(
                    FontAwesomeIcons.shoppingCart
                ),
                label: "Basket",
              ),


              BottomNavigationBarItem(
                icon: Icon(
                    FontAwesomeIcons.firstOrder
                ),
                label: "Orders",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                    FontAwesomeIcons.blog
                ),
                label: "Blog",

              ),
            ],
          ),
        ),
      ),
    );
  }
}