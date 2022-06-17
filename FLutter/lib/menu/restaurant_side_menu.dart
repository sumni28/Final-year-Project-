
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/About/ContactPage.dart';
import 'package:kkhaney/AccountNotification/AccountPage.dart';
import 'package:kkhaney/AccountNotification/EditProfile.dart';
import 'package:kkhaney/Blog/BlogPage.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/FoodViewPage.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantList.dart';
import 'package:kkhaney/Restaurantfromfilter/user_drink_menu.dart';
import 'package:kkhaney/Restaurantfromfilter/user_food_menu.dart';
import 'package:kkhaney/menu/manager/restaurant_menu_manager.dart';
import 'package:kkhaney/menu/restaurant_drink.dart';
import 'package:kkhaney/menu/restaurant_food.dart';
import 'package:provider/provider.dart';

class RestaurantMenu extends StatefulWidget {
  int userSurfingRestaurantId;
  RestaurantMenu({
    this.userSurfingRestaurantId=0,
    Key? key
  }) : super(key: key);

  @override
  _RestaurantMenuState createState() => _RestaurantMenuState();
}

class _RestaurantMenuState extends State<RestaurantMenu> {
  var _currentPage = 0;
  List<Widget> screens = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens.add(widget.userSurfingRestaurantId!=0?UserFoodMenu():RestaurantFood());
    screens.add(widget.userSurfingRestaurantId!=0?UserDrinkMenu():RestaurantDrink());

  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>RestaurantMenuManager(restaurantId: widget.userSurfingRestaurantId),
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
                icon: Icon(
                    FontAwesomeIcons.pizzaSlice
                ),
                label: "Food",

              ),
              BottomNavigationBarItem(
                icon: Icon(
                    FontAwesomeIcons.coffee
                ),
                label: "Drink",
              ),


            ],
          ),
        ),
      ),
    );
  }
}