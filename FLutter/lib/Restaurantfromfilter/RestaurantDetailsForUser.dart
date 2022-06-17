import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kkhaney/Constant.dart';
import 'package:kkhaney/FoodPostDetail/Widget/IngredientsContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/IngredientsContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/Menu.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/PriceContainer.dart';
import 'package:kkhaney/FoodPostDetail/Widget/TimeStartCalorie.dart';
import 'package:kkhaney/Icons/LikeIcon.dart';
import 'package:kkhaney/Model/FoodModel.dart';
import 'package:kkhaney/RestaurantArea/manager/restaurant_profile_manager.dart';
import 'package:kkhaney/Restaurantfromfilter/RestaurantWidget.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_comment_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/manager/restaurant_feedback_provider.dart';
import 'package:kkhaney/Restaurantfromfilter/restaurant_like.dart';
import 'package:kkhaney/menu/restaurant_side_menu.dart';
import 'package:provider/provider.dart';

class RestaurantDetailsForUser extends StatelessWidget {
  final RestaurantModal data;

  const RestaurantDetailsForUser({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) =>
              RestaurantFeedbackProvider(restaurantId: data.id),
        ),
        ChangeNotifierProvider(
          create: (context) => RestaurantCommentProvider(restaurantId: data.id),
        )
      ],
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: height,
                width: width,
                color: Constant.primaryColor,
                child: Column(
                  children: [
                    SizedBox(
                      height: 87,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: width,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  data.restaurantImage,
                                  height: 260,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                data.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),

                              Consumer<RestaurantFeedbackProvider>(
                                builder: (context,provider,child) {
                                  return provider.totalRatingLikesLoading?
                                  Center(
                                    child: CircularProgressIndicator(),
                                  ):TimeStar(
                                    startingEnding: "${data.openingTime} to ${data.closingTime}",
                                    rating: provider.totalRating.toString(),
                                    heart: provider.totalLikes.toString(),
                                  );
                                }
                              ),
                              RestaurantRatingWidget(),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.mapMarkerAlt,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    data.location,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                  "Minimum Order: Rs "+data.minimumOrder.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text("Cusine: "+data.cusine),
                              SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                      ),
                                    ),
                                    Text(data.restaurantInfo),

                                  ],
                                ),
                              ),

                              SizedBox(
                                height: 15,
                              ),
                              ElevatedButton(
                                  onPressed: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context)=>RestaurantMenu(userSurfingRestaurantId: data.id,))
                                    );
                                  },
                                  child: Text(
                                    "Open Menu"
                                  )
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              IngredientsContainer(),
                              SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Restaurant Comments",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              RestaurantUserComments(),
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 22,
                child: ClipOval(
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_arrow_left_outlined),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 20,
                  right: 22,
                  child: RestaurantLikeIcon(
                    isbig: true,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class RestaurantUserComments extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();

  RestaurantUserComments({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantCommentProvider>(
        builder: (context, provider, child) {
      return provider.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: Constant.getDecoration("Send Comment"),
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          provider.addComment(textEditingController.text);
                        },
                        child: Text("Comment"))
                  ],
                ),
                provider.commentsList.isEmpty
                    ? Center(
                        child: Text("No Comments"),
                      )
                    : SizedBox(
                        height: 200,
                        child: ListView.builder(
                          reverse: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return SingleCommentWidget(
                              comments: provider.commentsList[index],
                            );
                          },
                          itemCount: provider.commentsList.length,
                        ),
                      )
              ],
            );
    });
  }
}

class SingleCommentWidget extends StatelessWidget {
  final UserComments comments;

  const SingleCommentWidget({
    required this.comments,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    comments.user,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
                SizedBox(
                  width: 30,
                )
              ],
            ),
            Text(
              comments.comment,
            ),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Text(
                    comments.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantRatingWidget extends StatelessWidget {
  const RestaurantRatingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<RestaurantFeedbackProvider>(
        builder: (context, provider, child) {
      return Center(
        child: SizedBox(
          width: size.width * 0.6,
          child: Card(
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: provider.loadingLikeRating
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        for (int i = 1; i <= 5; i++)
                          Expanded(
                              child: InkWell(
                            onTap: () {
                              if (i != provider.userRating) {
                                provider.addFeedback(enteredRating: i);
                              } else if (i == 1) {
                                provider.addFeedback(enteredRating: 0);
                              }
                            },
                            child: Icon(
                              provider.userRating >= i
                                  ? Icons.star
                                  : Icons.star_border,
                              color:
                                  provider.userRating >= i ? Colors.yellow : null,
                            ),
                          ))
                      ],
                    ),
            ),
          ),
        ),
      );
    });
  }
}
