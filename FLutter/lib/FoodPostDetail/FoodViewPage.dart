import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kkhaney/Blog/Newrestaurant.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Home/widget/DrawerContainer.dart';
import 'package:kkhaney/Home/widget/FilteredListView.dart';
import 'package:kkhaney/Home/widget/FoodItemsList.dart';
import 'package:kkhaney/Home/widget/searchBoxWidget.dart';
import 'package:kkhaney/HomePageFoodPost/Breakfastcontainer.dart';
import 'package:kkhaney/HomePageFoodPost/CafeConatiner.dart';
import 'package:kkhaney/HomePageFoodPost/SpotLightContainer.dart';
import 'package:kkhaney/HomePageFoodPost/SupportLocalConatiner.dart';
import 'package:kkhaney/Model/FoodModel.dart';

class FoodViewPage extends StatelessWidget {
  const FoodViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        endDrawer: Drawer(
          child: DrawerContainer(

          ),
        ),
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            "K Khaney?",
            style: GoogleFonts.lobster(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.white
            ),
          )
        ),

        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchBoxWidget(),
              FilteredListView(),
              Divider(thickness: 5,),
              Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Newrestaurant(),
                        Divider(thickness: 5,),
                        Breakfastcontainer(),
                        Divider(thickness: 5,),
                        SpotLightContainer(),
                        Divider(thickness: 5,),
                        SupportlocalContainer(),
                        Divider(thickness: 5,),
                        CafeContainer(),
                      ],
                    ),
                  )
              )
          ]
          ),
        ),
      ),
    );
  }
}











