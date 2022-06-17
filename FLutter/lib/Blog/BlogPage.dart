import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kkhaney/Blog/BlogWidget.dart';
import 'package:kkhaney/Blog/Newrestaurant.dart';
import 'package:kkhaney/Blog/Offerwidget.dart';
import 'package:kkhaney/Blog/manager/user_blog_provider.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/Home/widget/DrawerContainer.dart';
import 'package:kkhaney/Home/widget/FilteredListView.dart';
import 'package:kkhaney/Home/widget/FoodItemsList.dart';
import 'package:kkhaney/Home/widget/searchBoxWidget.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_blog_manager.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantDetailsForUser.dart';
import 'package:provider/provider.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({Key? key}) : super(key: key);

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
          automaticallyImplyLeading: false,

          centerTitle: false,
          title: FittedBox(
            child: Row(
              children: [
                Text(
                  "K Khaney? Get your answer here",
                ),
                SizedBox(width: 30,)
              ],
            ),
          ),
        ),

        body: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.all(10),
          child:ChangeNotifierProvider(
            create: (context)=>UserBlogProvider(),
            child: Consumer<UserBlogProvider>(
              builder: (context,provider,child){
                if(provider.isLoading){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if(provider.blogList.isEmpty){
                  return Center(
                    child: Text(
                      "No Blog Available"
                    ),
                  );
                }
                return ListView.builder(
                  reverse: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: provider.blogList.length,
                    itemBuilder: (context,index){
                      return UserBlogWidget(blogModal: provider.blogList[index],);
                    }
                );
              },
            ),
          )
        ),
      ),
    );
  }
}

class UserBlogWidget extends StatelessWidget {
  final ServerBlogModal blogModal;
  const UserBlogWidget({
    required this.blogModal,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=>UserBlogSpecificPage(serverBlogModal: blogModal,)
            )
        );
      },
      child: SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Image.network(
                          blogModal.image,
                        fit: BoxFit.cover,
                      )
                  ),
                  Positioned.fill(
                      child: Center(
                        child: Container(
                          color: Constant.primaryColor.withOpacity(0.8),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              blogModal.heading,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Divider(
                color: Colors.grey.withOpacity(0.4),
                thickness: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class UserBlogSpecificPage extends StatelessWidget {
  final ServerBlogModal serverBlogModal;
  const UserBlogSpecificPage({
    required this.serverBlogModal,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return SafeArea(
        child:Scaffold(
          appBar: AppBar(
            title: Text(
              "Blog Detail"
            ),
          ),
          body: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.network(serverBlogModal.image),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    serverBlogModal.heading,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      decoration: TextDecoration.underline
                    ),
                  ),
                  SizedBox(height: 10,),
                  ElevatedButton(
                      onPressed: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>RestaurantDetailsForUser(data: serverBlogModal.restaurantModal!))
                        );
                      },
                      child: Text("Open Restaurant")
                  ),
                  SizedBox(height: 10,),
                  Text(
                    serverBlogModal.description,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lobster(),
                  ),

                ],
              ),
            ),
          ),
        )
    );
  }
}










